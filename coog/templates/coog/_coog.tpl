{{/*
Join components hosts in string format
*/}}
{{- define "backcore.coog.hosts" -}}
{{- if .Values.backCore.coog.ingress.hosts }}
{{- $hosts := list -}}
{{- range .Values.backCore.coog.ingress.hosts }}
{{- $hosts = .host | append $hosts -}}
{{- end -}}
{{- printf ",https://%s" (join ",https://" $hosts) }}
{{- end -}}
{{- end -}}

{{/*
Setup TRYTOND_WEB__CORS variable which has a dynamically generated part with the possibility of defining additional URLs
*/}}
{{- define "backcore.coog.trytonWebCors" -}}
{{- printf "https://%s" .Values.ingress.host -}}
{{- include "backcore.coog.hosts" . -}}
{{- if .Values.backCore.coog.trytonWebCorsAdditionals -}}
{{- printf ",%s" .Values.backCore.coog.trytonWebCorsAdditionals -}}
{{- end -}}
{{- end -}}