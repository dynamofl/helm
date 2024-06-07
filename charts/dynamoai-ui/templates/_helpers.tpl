{{/*
Expand the name of the chart.
*/}}
{{- define "dynamoai.name" -}}
{{- default .Release.Name .Values.global.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dynamoai.fullname" -}}
{{- if .Values.global.fullnameOverride }}
{{- .Values.global.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.global.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dynamoai.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dynamoai.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dynamoai.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "dynamoai.labels" -}}
helm.sh/chart: {{ include "dynamoai.chart" . }}
{{ include "dynamoai.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: {{ template "dynamoai.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.commonLabels}}
{{ toYaml .Values.commonLabels }}
{{- end }}
{{- end -}}

{{/*
Common annotations added to all resources.
*/}}
{{- define "dynamoai.annotations" -}}
helm.sh/chart: {{ include "dynamoai.chart" . }}
{{ include "dynamoai.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/part-of: {{ template "dynamoai.name" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/owned-by: "dynamoai"
{{- if .Values.commonAnnotations}}
{{ toYaml .Values.commonAnnotations }}
{{- end }}
{{- end -}}

{{/*
Return the service account name.
*/}}
{{- define "dynamoai.serviceAccountName" -}}
    {{ default "default" .Values.global.serviceAccount.name }}
{{- end -}}


{{/*
Return the appropriate apiVersion for Horizontal Pod Autoscaler.
*/}}
{{- define "dynamoai.hpa.apiVersion" -}}
{{- if $.Capabilities.APIVersions.Has "autoscaling/v2/HorizontalPodAutoscaler" }}
{{- print "autoscaling/v2" }}
{{- else }}
{{- print "autoscaling/v2beta2" }}
{{- end }}
{{- end }}

{{/*
Return the appropriate apiVersion for Pod Disuption Budget.
*/}}
{{- define "dynamoai.pdb.apiVersion" -}}
{{- if $.Capabilities.APIVersions.Has "policy/v1/PodDisruptionBudget" }}
{{- print "policy/v1" }}
{{- else }}
{{- print "policy/v1beta1" }}
{{- end }}
{{- end }}

{{/*
Common environment variables used in all Dynamo AI services.
*/}}
{{- define "dynamoai.commonEnv" -}}
- name: POD_NAME
  valueFrom:
    fieldRef:
      fieldPath: 'metadata.name'
- name: NAMESPACE
  valueFrom:
    fieldRef:
      fieldPath: 'metadata.namespace'
{{- end }}

{{/*
Common environment variables used in all Dynamo AI services, including secrets and config map values.
*/}}
{{- define "dynamoai.uiEnv" -}}
- name: DFL_UI_USERPOOL_ID
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: cognitoUserPoolId
- name: DFL_UI_USERPOOL_CLIENT_ID
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: cognitoClientId
{{- if .Values.global.apiDomain }}
- name: DFL_UI_BASEURL
  value: {{ .Values.global.apiDomain }}
{{- else }}
- name: DFL_UI_BASEURL
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.api }}
      key: domain
{{- end}}
{{- if .Values.keycloak.enabled }}
- name: DFL_KEYCLOAK_REALM
  value: 'dynamo-ai'
- name: DFL_KEYCLOAK_UI_CLIENT_ID
  value: 'ui'
- name: DFL_KEYCLOAK_BASE_URL
  value: {{ .Values.keycloak.baseUrl }}
{{ - end }}
{{- end }}
