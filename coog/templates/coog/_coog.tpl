yaml{{/*
Join components hosts in string format
*/}}
{{- define "backcore.coog.hosts" -}}
{{- $hosts := list -}}
{{- if .Values.backCore.coog.ingress.hosts }}
  {{- range .Values.backCore.coog.ingress.hosts }}
    {{- $hosts = append $hosts .host -}}
  {{- end -}}
{{- end -}}
{{- if .Values.backCore.coog.istio.hosts }}
  {{- range .Values.backCore.coog.istio.hosts }}
    {{- $hosts = append $hosts .host -}}
  {{- end -}}
{{- end -}}
{{- if $hosts }}
  {{- printf ",https://%s" (join ",https://" $hosts) -}}
{{- end -}}
{{- end -}}

{{/*
Setup TRYTOND_WEB__CORS variable which has a dynamically generated part with the possibility of defining additional URLs
*/}}
{{- define "backcore.coog.cors" -}}
{{- $mainHost := default .Values.ingress.host .Values.istio.mainHost -}}
{{- printf "https://%s" $mainHost -}}
{{- include "backcore.coog.hosts" . -}}
{{- $cors := list -}}
{{- if .Values.backCore.coog.ingress.nginx.whiteList.cors }}
  {{- range .Values.backCore.coog.ingress.nginx.whiteList.cors }}
    {{- $cors = append $cors . -}}
  {{- end -}}
{{- end -}}
{{- if .Values.backCore.coog.istio.whiteList.cors }}
  {{- range .Values.backCore.coog.istio.whiteList.cors }}
    {{- $cors = append $cors . -}}
  {{- end -}}
{{- end -}}
{{- if $cors }}
  {{- printf "\n%s" (join "\n" $cors) -}}
{{- end -}}
{{- end -}}