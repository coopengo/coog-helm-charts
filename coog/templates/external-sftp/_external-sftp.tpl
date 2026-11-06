{{/*
Shared SFTP server outside this release (saas-plateform chart, component sftp),
under Istio in its own namespace. These helpers serve the objects this release
renders in that namespace for the customer (externalSftp.*).
*/}}

{{/*
Name of the PV and of the PVC of the customer EFS in the SFTP namespace.
*/}}
{{- define "externalSftp.volumeName" -}}
{{- printf "sftp-%s" .Values.externalSftp.efsName -}}
{{- end -}}

{{/*
Labels of every object: the SFTP server finds the PVC of each customer by
sftp.coopengo.com/customer and mounts it at /mnt/<customer>/<efs-name>.
*/}}
{{- define "externalSftp.labels" -}}
{{ include "general.labels.standard" . }}
sftp.coopengo.com/customer: {{ .Values.externalSftp.customer }}
sftp.coopengo.com/efs-name: {{ .Values.externalSftp.efsName }}
{{- end -}}

{{/*
Home of the accounts: the EFS root as the SFTP server mounts it.
*/}}
{{- define "externalSftp.root" -}}
{{- printf "/mnt/%s/%s" .Values.externalSftp.customer .Values.externalSftp.efsName -}}
{{- end -}}

{{/*
Fails the render on a value the SFTP server would refuse, or that would open it
too widely. Run by validate.yaml, so that one check covers every object.
*/}}
{{- define "externalSftp.validate" -}}
{{- $s := .Values.externalSftp -}}
{{- $label := "^[a-z0-9]([-a-z0-9]{0,61}[a-z0-9])?$" -}}
{{- /* The SFTP pods name the customer volumes customer-<customer> (63 characters at most) */ -}}
{{- if not (regexMatch "^[a-z0-9]([-a-z0-9]{0,52}[a-z0-9])?$" (toString $s.customer)) -}}
{{- fail (printf "externalSftp.customer: %q must be a lowercase DNS label (letters, digits, '-', at most 54 characters)" (toString $s.customer)) -}}
{{- end -}}
{{- if not (regexMatch $label (toString $s.efsName)) -}}
{{- fail (printf "externalSftp.efsName: %q must be a lowercase DNS label (letters, digits, '-', at most 63 characters)" (toString $s.efsName)) -}}
{{- end -}}
{{- if not (and .Values.backCore.persistentVolume.enabled .Values.backCore.persistentVolume.customPersistentVolume) -}}
{{- fail "externalSftp needs backCore.persistentVolume.enabled and backCore.persistentVolume.customPersistentVolume: the SFTP server mounts the same EFS" -}}
{{- end -}}
{{- if not $s.selector -}}
{{- fail "externalSftp.selector must hold the labels of the SFTP server pods" -}}
{{- end -}}
{{- range $s.users -}}
{{- if not (regexMatch "^[A-Za-z0-9._-]+$" (toString .username)) -}}
{{- fail (printf "externalSftp.users: username %q may only hold letters, digits, '.', '_' and '-': the SFTP server refuses any other name" (toString .username)) -}}
{{- end -}}
{{- if not .publicKeys -}}
{{- fail (printf "externalSftp.users: %s has no public key" .username) -}}
{{- end -}}
{{- with .chroot -}}
{{- if or (not (regexMatch "^/?[A-Za-z0-9_.-]+(/[A-Za-z0-9_.-]+)*/?$" .)) (has ".." (splitList "/" .)) -}}
{{- fail (printf "externalSftp.users: chroot %q must be a path below the EFS root (letters, digits, '_', '.', '-', '/', no '..')" .) -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- range $s.allowedCidr -}}
{{- if not (regexMatch "^((25[0-5]|2[0-4][0-9]|1?[0-9]?[0-9])\\.){3}(25[0-5]|2[0-4][0-9]|1?[0-9]?[0-9])/([1-9]|[12][0-9]|3[0-2])$" (toString .)) -}}
{{- fail (printf "externalSftp.allowedCidr: %q must be an IPv4 CIDR such as 203.0.113.10/32, never /0: the policy would open SFTP to everyone" (toString .)) -}}
{{- end -}}
{{- end -}}
{{- end -}}
