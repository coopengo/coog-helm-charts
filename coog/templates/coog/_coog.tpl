{{/*
Join components hosts in string format
*/}}
{{- define "backcore.coog.hosts" -}}
{{- $hosts := list -}}
{{- range .Values.backCore.coog.ingress.hosts }}
{{- $hosts = .host | append $hosts -}}
{{- end -}}
{{- join ",https://"  $hosts }}
{{- end -}}