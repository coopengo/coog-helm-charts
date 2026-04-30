#!/usr/bin/env bash
#
# Rotate the RabbitMQ user password for a coog release deployed in mode "operator".
#
# Why this script exists
# ----------------------
# The RabbitMQ Messaging Topology Operator reads `spec.importCredentialsSecret`
# of a User CR ONLY at initial bootstrap (when `status.credentials.name` is empty).
# After that, the auto-generated Secret `<user-cr>-user-credentials` becomes the
# source of truth. Modifying `rabbitmq.auth.password` and running `helm upgrade`
# is silently a no-op for the broker.
#
# References:
#   - https://www.rabbitmq.com/kubernetes/operator/using-topology-operator
#   - https://github.com/rabbitmq/messaging-topology-operator/issues/571
#   - https://github.com/rabbitmq/messaging-topology-operator/pull/589
#
# This script implements the officially documented rotation procedure:
#   1. Patch the output Secret <user-cr>-user-credentials with the new password.
#   2. Annotate the User CR to trigger a reconcile.
#   3. Validate via rabbitmqctl that the broker accepts the new password.
#   4. List Deployments mounting the output Secret (to rollout-restart manually).
#
# The new password is read from the input Secret <release>-rabbitmq-credentials,
# which is the Secret rendered by Helm. Workflow:
#
#   helm upgrade <release> ... --set rabbitmq.auth.password=<new-pass>
#   ./scripts/rotate-rabbitmq-user.sh --release <release> --namespace <ns>
#
# This avoids passing the password as a CLI argument (visible to `ps`).

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  rotate-rabbitmq-user.sh --release <name> --namespace <ns> [options]

Required:
  --release <name>      Helm release name (e.g. coopengo-individuel-sandbox)
  --namespace <ns>      Namespace of the release

Options:
  --cluster-name <n>    RabbitmqCluster CR name           (default: rabbitmq-production)
  --cluster-ns <n>      RabbitmqCluster CR namespace      (default: rabbitmq-system)
  --no-validate         Skip the rabbitmqctl authenticate_user check
  -h, --help            Show this help

Prerequisites:
  - kubectl with access to <namespace> and <cluster-ns>
  - jq
  - The release was deployed with rabbitmq.mode=operator
  - helm upgrade has already been run with the new password
EOF
}

RELEASE=""
NAMESPACE=""
CLUSTER_NAME="rabbitmq-production"
CLUSTER_NS="rabbitmq-system"
NO_VALIDATE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --release)      RELEASE="${2:?--release needs a value}"; shift 2 ;;
    --namespace)    NAMESPACE="${2:?--namespace needs a value}"; shift 2 ;;
    --cluster-name) CLUSTER_NAME="${2:?--cluster-name needs a value}"; shift 2 ;;
    --cluster-ns)   CLUSTER_NS="${2:?--cluster-ns needs a value}"; shift 2 ;;
    --no-validate)  NO_VALIDATE=1; shift ;;
    -h|--help)      usage; exit 0 ;;
    *)              echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

[[ -z "$RELEASE"   ]] && { echo "--release is required" >&2;   exit 2; }
[[ -z "$NAMESPACE" ]] && { echo "--namespace is required" >&2; exit 2; }

for cmd in kubectl jq base64 date; do
  command -v "$cmd" >/dev/null || { echo "$cmd not found in PATH" >&2; exit 1; }
done

INPUT_SECRET="${RELEASE}-coog-rabbitmq-credentials"
USER_CR="${RELEASE}-coog-rabbitmq-user"
OUTPUT_SECRET="${USER_CR}-user-credentials"

log() { printf '>>> %s\n' "$*"; }
err() { printf '!!! %s\n' "$*" >&2; }

log "release=${RELEASE}  namespace=${NAMESPACE}"
log "input secret  : ${INPUT_SECRET}"
log "output secret : ${OUTPUT_SECRET}"
log "user CR       : ${USER_CR}"

if ! kubectl -n "$NAMESPACE" get secret "$INPUT_SECRET" >/dev/null 2>&1; then
  err "Input secret ${INPUT_SECRET} not found in ${NAMESPACE}."
  err "Did you run 'helm upgrade' with rabbitmq.mode=operator first?"
  exit 3
fi

NEW_PASS="$(kubectl -n "$NAMESPACE" get secret "$INPUT_SECRET" \
  -o jsonpath='{.data.password}' | base64 -d)"
USERNAME="$(kubectl -n "$NAMESPACE" get secret "$INPUT_SECRET" \
  -o jsonpath='{.data.username}' | base64 -d)"

if [[ -z "$NEW_PASS" || -z "$USERNAME" ]]; then
  err "username or password missing/empty in ${INPUT_SECRET}"
  exit 3
fi
if [[ "$NEW_PASS" == "changeme" ]]; then
  err "Refusing to rotate to the placeholder password 'changeme'."
  err "Set rabbitmq.auth.password to a real value via helm upgrade."
  exit 3
fi

if ! kubectl -n "$NAMESPACE" get user.rabbitmq.com "$USER_CR" >/dev/null 2>&1; then
  err "User CR ${USER_CR} not found in ${NAMESPACE}."
  err "Is rabbitmq.mode=operator? Was the release deployed?"
  exit 3
fi

if ! kubectl -n "$NAMESPACE" get secret "$OUTPUT_SECRET" >/dev/null 2>&1; then
  err "Output secret ${OUTPUT_SECRET} not found."
  err "It is normally created by the Topology Operator at User CR creation."
  err "If missing, check operator logs and that bootstrap succeeded."
  exit 3
fi

log "patching output secret"
PATCH="$(jq -nc --arg p "$NEW_PASS" '{stringData:{password:$p}}')"
kubectl -n "$NAMESPACE" patch secret "$OUTPUT_SECRET" --type=merge -p "$PATCH" >/dev/null

log "triggering reconcile of ${USER_CR}"
RECONCILE_TS="$(date +%s)"
kubectl -n "$NAMESPACE" annotate user.rabbitmq.com "$USER_CR" \
  "topology.rabbitmq.com/force-reconcile=${RECONCILE_TS}" --overwrite >/dev/null

log "waiting for reconcile (up to 60s)"
DEADLINE=$(( RECONCILE_TS + 60 ))
RECONCILED=0
while [[ "$(date +%s)" -lt "$DEADLINE" ]]; do
  LAST="$(kubectl -n "$NAMESPACE" get user.rabbitmq.com "$USER_CR" \
    -o jsonpath='{.status.conditions[?(@.type=="Ready")].lastTransitionTime}' 2>/dev/null || true)"
  if [[ -n "$LAST" ]]; then
    LAST_TS="$(date -d "$LAST" +%s 2>/dev/null || echo 0)"
    # The operator may reconcile without changing lastTransitionTime if Ready
    # was already True. Trust the annotation timestamp to avoid false positives:
    # we just wait a few seconds for the operator to process the event.
    if [[ "$LAST_TS" -ge "$RECONCILE_TS" ]]; then RECONCILED=1; break; fi
  fi
  sleep 2
done

if [[ "$RECONCILED" -eq 0 ]]; then
  log "no Ready transition observed within timeout; the operator likely reconciled"
  log "without changing status (already Ready). Continuing with validation."
fi

if [[ "$NO_VALIDATE" -eq 0 ]]; then
  log "validating against broker (rabbitmqctl authenticate_user)"
  if kubectl -n "$CLUSTER_NS" exec "${CLUSTER_NAME}-server-0" -c rabbitmq -- \
       rabbitmqctl authenticate_user "$USERNAME" "$NEW_PASS" >/dev/null 2>&1; then
    log "OK: broker accepts new password for user '${USERNAME}'"
  else
    err "broker rejected the new password for user '${USERNAME}'"
    err "check operator logs:"
    err "  kubectl -n ${CLUSTER_NS} logs deploy/messaging-topology-operator \\"
    err "    --tail=50 | grep ${USER_CR}"
    exit 4
  fi
fi

log "deployments mounting ${OUTPUT_SECRET} (rollout-restart manually if needed):"
DEPLOYS="$(kubectl -n "$NAMESPACE" get deploy -o json \
  | jq -r --arg s "$OUTPUT_SECRET" '
      .items[]
      | select(
          ((.spec.template.spec.volumes // [])[]?.secret.secretName == $s)
          or
          (((.spec.template.spec.containers // [])[]?.envFrom // [])[]?.secretRef.name == $s)
          or
          (((.spec.template.spec.containers // [])[]?.env // [])[]?.valueFrom.secretKeyRef.name == $s)
        )
      | .metadata.name')"
if [[ -z "$DEPLOYS" ]]; then
  log "  (none found — clients may consume credentials another way)"
else
  echo "$DEPLOYS" | sed 's/^/    - /'
fi

log "done."
