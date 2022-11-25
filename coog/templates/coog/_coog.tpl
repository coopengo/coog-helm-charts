{{/*
Join components hosts in string format
*/}}
{{- define "backcore.coog.hosts" -}}
{{- $map := dict }}
{{- range .Values.backCore.coog.ingress.hosts }}
{{- if .host }}
{{- $_ := set $map .host "" }}
{{- end }}
{{- keys $map | join ",https://" }}
{{- end }}
{{- end }}