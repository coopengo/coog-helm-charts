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
{{- if and .Values.backCore.coog.istio.hosts .Values.istio.enabled }}
  {{- range .Values.backCore.coog.istio.hosts }}
    {{- $hosts = append $hosts .host -}}
  {{- end -}}
{{- end -}}
{{- if $hosts }}
  {{- printf "\nhttps://%s" (join "\nhttps://" $hosts) -}}
{{- end -}}
{{- end -}}

{{/*
Setup TRYTOND_WEB__CORS variable which has a dynamically generated part with the possibility of defining additional URLs
*/}}
{{- define "backcore.coog.cors" -}}
{{- $mainHost := ternary (default .Values.ingress.host .Values.istio.mainHost) .Values.ingress.host .Values.istio.enabled -}}
{{- printf "https://%s" $mainHost -}}
{{- include "backcore.coog.hosts" . -}}
{{- /* The gateway rewrites the Origin header to its COOG_URL origin before proxying to coog */ -}}
{{- if (or .Values.frontCore.enabled
          .Values.apiB2c.enabled
          .Values.apiReferential.enabled
          .Values.b2c.enabled
          .Values.b2b.enabled
          .Values.customerBackend.enabled
          .Values.customerFrontend.enabled)
}}
  {{- printf "\nhttp://%s" (include "general.names.short" .) -}}
{{- end -}}
{{- $cors := list -}}
{{- if .Values.backCore.coog.ingress.nginx.whiteList.cors }}
  {{- range .Values.backCore.coog.ingress.nginx.whiteList.cors }}
    {{- $cors = append $cors . -}}
  {{- end -}}
{{- end -}}
{{- if and .Values.backCore.coog.istio.whiteList.cors .Values.istio.enabled }}
  {{- range .Values.backCore.coog.istio.whiteList.cors }}
    {{- $cors = append $cors . -}}
  {{- end -}}
{{- end -}}
{{- if $cors }}
  {{- printf "\n%s" (join "\n" $cors) -}}
{{- end -}}
{{- end -}}
