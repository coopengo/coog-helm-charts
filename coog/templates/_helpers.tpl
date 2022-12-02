{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "general.names.name" -}}
{{- $tplDir := base (dir .Template.Name) -}}
{{- if eq "templates" $tplDir -}}
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
Return the proper image name
{{ include "general.images.image" ( dict "imageRoot" .Values.path.to.the.image "global" $) }}
*/}}
{{- define "general.images.image" -}}
{{- $registryName := .imageRoot.registry -}}
{{- $repositoryName := .imageRoot.repository -}}
{{- $tag := .imageRoot.tag | toString -}}
{{- if $registryName }}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag -}}
{{- else -}}
{{- printf "%s:%s" $repositoryName $tag -}}
{{- end -}}
{{- end -}}

{{/*
Ingress dynamic configuration
*/}}
{{- define "general.ingress.apiVersion" -}}
{{- if semverCompare "<1.14.0" .Capabilities.KubeVersion.Version -}}
{{- print "extensions/v1beta1" -}}
{{- else if semverCompare "<1.19.0" .Capabilities.KubeVersion.Version -}}
{{- print "networking.k8s.io/v1beta1" -}}
{{- else -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}
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
{{- $secretValue := (get $secretData .key) | default (randAlphaNum 32) -}}
{{ .key }}: {{ $secretValue | quote }}
{{- end -}}

{{/*
Create image pull secret string.
*/}}
{{- define "imagePullSecret" }}
{{- with .Values.imageCredentials }}
{{- printf "{\"auths\":{\"%s\":{\"username\":\"%s\",\"password\":\"%s\",\"email\":\"%s\",\"auth\":\"%s\"}}}" .registry .username .password .email (printf "%s:%s" .username .password | b64enc) | b64enc }}
{{- end }}
{{- end }}
