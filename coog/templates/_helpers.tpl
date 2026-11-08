{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "general.names.name" -}}
{{- $tplDir := base (dir .Template.Name) -}}
{{- if or (eq "templates" $tplDir) (eq "coog" $tplDir) -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Chart.Name $tplDir | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "general.names.fullname" -}}
{{- $tplDir := base (dir .Template.Name) -}}
{{- if eq "templates" $tplDir -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name .Chart.Name $tplDir | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "general.names.short" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "general.names.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Define general namespace
*/}}
{{- define "general.namespace" -}}
    {{- print .Release.Namespace -}}
{{- end -}}

{{/*
Kubernetes standard labels
*/}}
{{- define "general.labels.standard" -}}
app.kubernetes.io/name: {{ include "general.names.name" . }}
helm.sh/chart: {{ include "general.names.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
{{- end -}}

{{/*
Labels to use on deploy.spec.selector.matchLabels and svc.spec.selector
*/}}
{{- define "general.labels.matchLabels" -}}
app.kubernetes.io/name: {{ include "general.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Renders a value that contains template.
Usage:
{{ include "general.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "general.tplvalues.render" -}}
{{- if typeIs "string" .value }}
{{- tpl .value .context }}
{{- else }}
{{- tpl (.value | toYaml) .context }}
{{- end }}
{{- end -}}

{{/*
Return  the proper Storage Class
{{ include "storage.class" (dict "value" .Values.path.to.the.Value) | nindent X }}
*/}}
{{- define "storage.class" -}}
{{- $storageClass := .value -}}
{{- if $storageClass -}}
{{- if (eq "-" $storageClass) -}}
{{- printf "storageClassName: \"\"" -}}
{{- else }}
{{- printf "storageClassName: %s" $storageClass -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Generate tokens for some variables
Usage
{{- if not .Values.secrets.backCore.extraEnvVar.TRYTOND_SESSION__PASSPHRASE }}
TRYTOND_SESSION__PASSPHRASE: {{ include "secret.token.generator" (dict "value" "TRYTOND_SESSION__PASSPHRASE" "secretName" (printf "%s-backcore-configuration" (include "general.names.short" .))) | quote }}
{{- end }}
*/}}
{{- define "secret.token.generator" -}}
{{- $secretObj := (lookup "v1" "Secret" .namespace .secretName) | default dict -}}
{{- $secretData := (get $secretObj "data") | default dict -}}
{{- $secretValue := (get $secretData .key | b64dec) | default (randAlphaNum 32) -}}
{{ .key }}: {{ $secretValue | quote }}
{{- end -}}


{{/*
Join TRYTOND_DATABASE_NAMES in string format
*/}}
{{- define "postgres.databases" -}}
{{ .Values.postgresql.auth.database }}
{{- if .Values.backCore.extraDatabases }}
{{- $databases := list -}}
{{- range .Values.backCore.extraDatabases }}
{{- $databases = . | append $databases -}}
{{- end -}}
{{- printf ",%s" (join "," $databases) }}
{{- end -}}
{{- end -}}


{{/*
Join mongodb hosts in string format
*/}}
{{- define "mongodb.uri" -}}
{{- $replicaCount := int .Values.mongodb.replicaCount }}
{{- $portNumber := int .Values.mongodb.service.ports.mongodb }}
{{- $fullname := printf "%s-mongodb" .Release.Name }}
{{- $releaseNamespace := include "general.namespace" . }}
{{- $clusterDomain := .Values.clusterDomain }}
{{- $hosts := list -}}
{{- $options := list -}}
{{- $protocol := "mongodb://" -}}
{{- $srvEnabled := .Values.mongodb.srv_uri | default false -}}
{{- if $srvEnabled -}}
{{- $protocol = "mongodb+srv://" -}}
{{- end -}}
{{- range .Values.mongodb.uriOptions -}}
{{- $options = printf "%s" . | append $options -}}
{{- end -}}
{{- if .Values.mongodb.hosts -}}
{{- range .Values.mongodb.hosts -}}
{{- if $srvEnabled -}}
{{- $hosts = printf "%s" . | append $hosts -}}
{{- else -}}
{{- $hosts = printf "%s" . | append $hosts -}}
{{- end -}}
{{- end -}}
{{- printf "%s%s:%s@%s/%s" $protocol (first $.Values.mongodb.auth.usernames) (first $.Values.mongodb.auth.passwords) (join "," $hosts) (first $.Values.mongodb.auth.databases) }}
{{- else -}}
{{- if eq .Values.mongodb.architecture "replicaset" -}}
{{- range $e, $i := until $replicaCount }}
{{- if $srvEnabled -}}
{{- $hosts = printf "%s-%d.%s-headless.%s.svc.%s" $fullname $i $fullname $releaseNamespace $clusterDomain | append $hosts }}
{{- else -}}
{{- $hosts = printf "%s-%d.%s-headless.%s.svc.%s:%d" $fullname $i $fullname $releaseNamespace $clusterDomain $portNumber | append $hosts }}
{{- end -}}
{{- end }}
{{- printf "%s%s:%s@%s/%s?replicaSet=%s" $protocol (first .Values.mongodb.auth.usernames) (first .Values.mongodb.auth.passwords) (join "," $hosts) (first .Values.mongodb.auth.databases) .Values.mongodb.replicaSetName }}
{{- else -}}
{{- if $srvEnabled -}}
{{- printf "%s%s:%s@%s/%s" $protocol (first .Values.mongodb.auth.usernames) (first .Values.mongodb.auth.passwords) $fullname (first .Values.mongodb.auth.databases) }}
{{- else -}}
{{- printf "%s%s:%s@%s:%d/%s" $protocol (first .Values.mongodb.auth.usernames) (first .Values.mongodb.auth.passwords) $fullname $portNumber (first .Values.mongodb.auth.databases) }}
{{- end -}}
{{- end -}}
{{- end -}}
{{- if $options -}}
{{- printf "?%s" (join "?" $options) }}
{{- end -}}
{{- end -}}


{{/*
Create image pull secret string.
*/}}
{{- define "imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}

{{/*
Return true ("true") when the chart runs in RabbitMQ operator mode.
Operator mode is selected exclusively via `rabbitmq.mode == "operator"`,
which is the single source of truth.
Usage: {{ if eq (include "coog.rabbitmq.operatorMode" .) "true" }}
*/}}
{{- define "coog.rabbitmq.operatorMode" -}}
{{- $mode := default "legacy" .Values.rabbitmq.mode -}}
{{- if eq $mode "operator" -}}
true
{{- else -}}
false
{{- end -}}
{{- end -}}

{{/*
Fail-fast guard: in operator mode the Bitnami sub-chart MUST be disabled
(`rabbitmq.isManaged: false`). Renders nothing on success, aborts the
release otherwise with an actionable error message.
Usage: {{ include "coog.rabbitmq.assertOperatorMode" . }}
*/}}
{{- define "coog.rabbitmq.assertOperatorMode" -}}
{{- if eq (include "coog.rabbitmq.operatorMode" .) "true" -}}
{{- if .Values.rabbitmq.isManaged -}}
{{- fail "rabbitmq.mode=operator requires rabbitmq.isManaged=false to disable the Bitnami sub-chart and avoid a double deployment." -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
RabbitMQ vhost name used by the application AMQP URI and the Vhost CRD.
- Operator mode: defaults to "/<release-name>" unless `rabbitmq.operator.vhost` is set.
- Legacy mode: returns `.Values.rabbitmq.vhost` as-is (may be empty).
The value is returned WITH the leading slash when it makes sense semantically;
helpers that build the AMQP URI strip it (the AMQP URI uses the vhost path
component without leading slash, RFC-3986 style).
Usage: {{ include "coog.rabbitmq.vhost" . }}
*/}}
{{- define "coog.rabbitmq.vhost" -}}
{{- if eq (include "coog.rabbitmq.operatorMode" .) "true" -}}
{{- $v := default "" .Values.rabbitmq.operator.vhost -}}
{{- if $v -}}
{{- $v -}}
{{- else -}}
{{- printf "/%s" .Release.Name -}}
{{- end -}}
{{- else -}}
{{- default "" .Values.rabbitmq.vhost -}}
{{- end -}}
{{- end -}}

{{/*
RabbitMQ vhost path component for the AMQP URI (no leading slash).
Returns an empty string when no vhost is configured (legacy default).
Usage: {{ include "coog.rabbitmq.vhostPath" . }}
*/}}
{{- define "coog.rabbitmq.vhostPath" -}}
{{- $v := include "coog.rabbitmq.vhost" . -}}
{{- if hasPrefix "/" $v -}}
{{- trimPrefix "/" $v -}}
{{- else -}}
{{- $v -}}
{{- end -}}
{{- end -}}

{{/*
RabbitMQ host used by the AMQP URI.
- Operator mode: Service DNS of the external RabbitmqCluster
  (`<cluster>.<cluster-namespace>.svc.cluster.local`), unless overridden
  via `rabbitmq.host`.
- Legacy mode: `<release>-rabbitmq` (Bitnami sub-chart Service), unless
  overridden via `rabbitmq.host`.
Usage: {{ include "coog.rabbitmq.host" . }}
*/}}
{{- define "coog.rabbitmq.host" -}}
{{- if .Values.rabbitmq.host -}}
{{- .Values.rabbitmq.host -}}
{{- else if eq (include "coog.rabbitmq.operatorMode" .) "true" -}}
{{- $cluster := .Values.rabbitmq.operator.cluster.name -}}
{{- $clusterNs := .Values.rabbitmq.operator.cluster.namespace -}}
{{- printf "%s.%s.svc.cluster.local" $cluster $clusterNs -}}
{{- else -}}
{{- printf "%s-rabbitmq" .Release.Name -}}
{{- end -}}
{{- end -}}

{{/*
Fully-qualified RabbitMQ host used by Istio DestinationRule (which requires
an FQDN). Appends `.svc.cluster.local` unless the host already ends with it
(e.g. operator mode where the helper already returns a full Service DNS).
Usage: {{ include "coog.rabbitmq.hostFqdn" . }}
*/}}
{{- define "coog.rabbitmq.hostFqdn" -}}
{{- $h := include "coog.rabbitmq.host" . -}}
{{- if hasSuffix ".svc.cluster.local" $h -}}
{{- $h -}}
{{- else -}}
{{- printf "%s.svc.cluster.local" $h -}}
{{- end -}}
{{- end -}}

{{/*
Resolve a Portal V2 image name. When .Values.portalV2 is true and the name starts
with "coog-" but not already with "coog-portal-", insert the "portal-" segment so
that "coog-X" becomes "coog-portal-X". Names already prefixed with "coog-portal-"
are returned as-is (no double-prefix). Names not starting with "coog-" are returned
unchanged.
Usage:
  {{ include "portal.image.name" (dict "name" .Values.frontCore.gateway.image.name "context" $) }}
*/}}
{{- define "portal.image.name" -}}
{{- $name := .name -}}
{{- if and .context.Values.portalV2 (hasPrefix "coog-" $name) (not (hasPrefix "coog-portal-" $name)) -}}
{{- $name = printf "coog-portal-%s" (trimPrefix "coog-" $name) -}}
{{- end -}}
{{- $name -}}
{{- end -}}

{{/*
Pod-level resources (pod spec.resources) of a workload: for each resource, the max of the
values declared by its containers (containers, init containers and, with istio.enabled, the
istio-proxy sidecar). The containers share that envelope:
- cpu and memory only, the resources pod-level resources accept;
- a request left out takes the limit, as Kubernetes defaults it;
- a pod limit is set only when every container sets one for that resource (otherwise the
  pod was not bounded on it);
- istio.proxy.resources is part of the max because istiod injects the sidecar with its own
  requests, and the API rejects a pod whose requests are below its containers' requests.
Usage:
  {{- with include "general.resources.pod" (dict "containers" (list .Values.x.resources) "initContainers" (list .Values.x.initContainers.resources) "context" $) }}
  resources: {{- . | nindent 8 }}
  {{- end }}
*/}}
{{- define "general.resources.pod" -}}
{{- $all := concat (default (list) .containers) (default (list) .initContainers) -}}
{{- if .context.Values.istio.enabled -}}
{{- $all = append $all .context.Values.istio.proxy.resources -}}
{{- end -}}
{{- $pod := dict "requests" (dict) "limits" (dict) -}}
{{- range $name := list "cpu" "memory" -}}
{{- range $kind := list "requests" "limits" -}}
{{- $max := 0 -}}
{{- $declared := false -}}
{{- $unbounded := false -}}
{{- range $res := $all -}}
{{- $value := "" -}}
{{- if kindIs "map" $res -}}
{{- include "general.resources.check" $res -}}
{{- $value = toString (get (get $res $kind | default dict) $name) -}}
{{- if and (eq $kind "requests") (eq $value "") -}}
{{- $value = toString (get (get $res "limits" | default dict) $name) -}}
{{- end -}}
{{- end -}}
{{- if eq $value "" -}}
{{- $unbounded = true -}}
{{- else -}}
{{- $declared = true -}}
{{- $max = max $max (include "general.quantity.parse" (dict "name" $name "value" $value) | int64) -}}
{{- end -}}
{{- end -}}
{{- if and $declared (or (eq $kind "requests") (not $unbounded)) -}}
{{- $_ := set (get $pod $kind) $name (include "general.quantity.format" (dict "name" $name "value" $max)) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- range $kind := list "requests" "limits" -}}
{{- if not (get $pod $kind) -}}
{{- $_ := unset $pod $kind -}}
{{- end -}}
{{- end -}}
{{- with $pod -}}
{{- toYaml . -}}
{{- end -}}
{{- end -}}

{{/*
Fail on what pod-level resources do not accept: keys other than requests and limits,
resources other than cpu and memory.
*/}}
{{- define "general.resources.check" -}}
{{- range $kind, $values := . -}}
{{- if not (has $kind (list "requests" "limits")) -}}
{{- fail (printf "resources.%s: pod-level resources only accept requests and limits" $kind) -}}
{{- end -}}
{{- range $name, $_ := ($values | default dict) -}}
{{- if not (has $name (list "cpu" "memory")) -}}
{{- fail (printf "resources.%s.%s: pod-level resources only accept cpu and memory" $kind $name) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Kubernetes quantity to an integer: millicores for cpu ("1", "1.5", "300m"), bytes for memory
("700Mi", "1Gi", "1G", "1048576").
Usage: {{ include "general.quantity.parse" (dict "name" "cpu" "value" "300m") | int64 }}
*/}}
{{- define "general.quantity.parse" -}}
{{- $value := toString .value -}}
{{- if eq .name "cpu" -}}
{{- if not (regexMatch "^([0-9]+(\\.[0-9]+)?|\\.[0-9]+)m?$" $value) -}}
{{- fail (printf "resources: invalid cpu quantity %q" $value) -}}
{{- end -}}
{{- if hasSuffix "m" $value -}}
{{- trimSuffix "m" $value | float64 | ceil | int64 -}}
{{- else -}}
{{- mulf (float64 $value) 1000 | ceil | int64 -}}
{{- end -}}
{{- else -}}
{{- if not (regexMatch "^[0-9]+(\\.[0-9]+)?(Ki|Mi|Gi|Ti|k|M|G|T)?$" $value) -}}
{{- fail (printf "resources: invalid memory quantity %q" $value) -}}
{{- end -}}
{{- $number := regexFind "^[0-9]+(\\.[0-9]+)?" $value -}}
{{- $units := dict "" 1 "k" 1000 "M" 1000000 "G" 1000000000 "T" 1000000000000 "Ki" 1024 "Mi" 1048576 "Gi" 1073741824 "Ti" 1099511627776 -}}
{{- mulf (float64 $number) (get $units (trimPrefix $number $value)) | ceil | int64 -}}
{{- end -}}
{{- end -}}

{{/*
Integer from general.quantity.parse back to a quantity: "1300m" for cpu, "1750Mi" for memory
(Ki, or bytes, when it is not a whole number of Mi).
*/}}
{{- define "general.quantity.format" -}}
{{- $value := .value | int64 -}}
{{- if eq .name "cpu" -}}
{{- printf "%dm" $value -}}
{{- else if eq (mod $value 1048576) 0 -}}
{{- printf "%dMi" (div $value 1048576) -}}
{{- else if eq (mod $value 1024) 0 -}}
{{- printf "%dKi" (div $value 1024) -}}
{{- else -}}
{{- printf "%d" $value -}}
{{- end -}}
{{- end -}}

{{/*
Generate LibroConv API URI based on deployment mode (shared vs per-tenant)
Usage: {{ include "libroconv.uri" . }}
*/}}
{{- define "libroconv.uri" -}}
{{- $protocol := "http://" -}}
{{- $port := .Values.libroconv.externalPort | default 5000 | toString -}}
{{- $basePath := "/unoconv/{oext}" -}}
{{- $externalAddress := .Values.libroconv.externalAddress | default "" -}}
{{- $releaseNamespace := include "general.namespace" . -}}

{{- if and (not .Values.libroconv.enabled) .Values.libroconv.externalAddress -}}
{{- printf "%s%s:%s%s/%s" $protocol $externalAddress $port $basePath $releaseNamespace -}}
{{- else if .Values.libroconv.enabled -}}
{{- $serviceName := printf "%s-libroconv" (include "general.names.short" .) -}}
{{- printf "%s%s:%s%s" $protocol $serviceName $port $basePath -}}
{{- end -}}
{{- end -}}
