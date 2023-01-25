{{/*
Join components hosts in string format
*/}}
{{- define "frontcore.gateway.hosts" -}}
{{- if .Values.frontCore.gateway.ingress.hosts }}
{{- $hosts := list -}}
{{- range .Values.frontCore.gateway.ingress.hosts  }}
{{- $hosts = .host | append $hosts -}}
{{- end -}}
{{- printf ",https://%s" (join ",https://" $hosts) }}
{{- end -}}
{{- end -}}


{{/*
Setup "WHITELIST" variable which has a dynamically generated part with the possibility of defining additional URLs
*/}}
{{- define "frontcore.gateway.cors" -}}
http://localhost:4000,{{ printf "https://%s" .Values.ingress.host }}
{{- include "frontcore.gateway.hosts" . -}}
{{- if .Values.frontCore.gateway.ingress.nginx.whiteList.cors -}}
{{- $cors := list -}}
{{- range .Values.frontCore.gateway.ingress.nginx.whiteList.cors }}
{{- $cors = . | append $cors -}}
{{- end -}}
{{- printf ",%s" (join "," $cors) }}
{{- end -}}
{{- end -}}