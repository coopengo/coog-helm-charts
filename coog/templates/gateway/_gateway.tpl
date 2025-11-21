yaml{{/*
Join components hosts in string format
*/}}
{{- define "frontcore.gateway.hosts" -}}
{{- $hosts := list -}}
{{- if .Values.frontCore.gateway.ingress.hosts }}
  {{- range .Values.frontCore.gateway.ingress.hosts }}
    {{- $hosts = append $hosts .host -}}
  {{- end -}}
{{- end -}}
{{- if .Values.frontCore.gateway.istio.hosts }}
  {{- range .Values.frontCore.gateway.istio.hosts }}
    {{- $hosts = append $hosts .host -}}
  {{- end -}}
{{- end -}}
{{- if $hosts }}
  {{- printf ",https://%s" (join ",https://" $hosts) -}}
{{- end -}}
{{- end -}}

{{/*
Setup "WHITELIST" variable which has a dynamically generated part with the possibility of defining additional URLs
*/}}
{{- define "frontcore.gateway.cors" -}}
{{- $mainHost := default .Values.ingress.host .Values.istio.mainHost -}}
http://localhost:4000,{{ printf "https://%s" $mainHost -}}
{{- include "frontcore.gateway.hosts" . -}}
{{- $cors := list -}}
{{- if .Values.frontCore.gateway.ingress.nginx.whiteList.cors }}
  {{- range .Values.frontCore.gateway.ingress.nginx.whiteList.cors }}
    {{- $cors = append $cors . -}}
  {{- end -}}
{{- end -}}
{{- if .Values.frontCore.gateway.istio.whiteList.cors }}
  {{- range .Values.frontCore.gateway.istio.whiteList.cors }}
    {{- $cors = append $cors . -}}
  {{- end -}}
{{- end -}}
{{- if $cors }}
  {{- printf ",%s" (join "," $cors) -}}
{{- end -}}
{{- end -}}