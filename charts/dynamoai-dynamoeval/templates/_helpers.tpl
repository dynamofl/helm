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
{{- define "dynamoai.dbMigrationsJobEnv" -}}
- name: PG_DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: host
- name: PG_DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: name
- name: PG_DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: username
- name: PG_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: password
- name: PG_DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: port
{{- end }}

{{/*
Common environment variables used in all Dynamo AI services, including secrets and config map values.
*/}}
{{- define "dynamoai.scaledJobCommonEnv" -}}
{{- if .Values.global.secrets.postgres }}
- name: PG_DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: host
- name: PG_DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: name
- name: PG_DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: username
- name: PG_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: password
- name: PG_DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: port
{{- end }}
{{- if .Values.global.secrets.mongodb }}
- name: DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.mongodb }}
      key: host
- name: DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.mongodb }}
      key: username
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.mongodb }}
      key: password
- name: DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.mongodb }}
      key: port
{{- end }}
{{- if .Values.global.secrets.redis }}
- name: REDIS_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.redis }}
      key: host
- name: REDIS_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.redis }}
      key: port
{{- end }}
{{- if .Values.nats.enabled }}
- name: NATS_SERVER
  value: {{ .Values.nats.serverUrl }}
{{- end}}
{{- if .Values.global.awsRegion }}
- name: AWS_DEFAULT_REGION
  value: "{{ .Values.global.awsRegion }}"
{{- end }}
- name: MAX_REQUESTS_TO_PROCESS
  value: '1'
{{- end }}

{{- define "dynamoai.testReportGenerationScaledJobEnv" -}}
- name: REDIS_QUEUE
  value: "{{ .Values.testReportGeneration.name }}"
{{- end }}

{{- define "dynamoai.pentestEnv" -}}
- name: OPENAI_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: openai_api_key
- name: MISTRAL_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: mistral_api_key
{{- if .Values.global.apiDomain }}
- name: API_DOMAIN
  value: {{ .Values.global.apiDomain }}
{{- else }}
- name: API_DOMAIN
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.api }}
      key: domain
{{- end}}
- name: PENTEST_BUCKET
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: bucketName
- name: PENTEST_SERVICE_USER_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: pentest_service_user_api_key
{{- end }}

{{- define "dynamoai.gpuTypeCountScaledJobEnv" -}}
- name: REDIS_QUEUE
  value: "queue-{{ .type }}-{{ .count }}"
{{- end }}

{{- define "dynamoai.gpuMemoryCountScaledJobEnv" -}}
- name: REDIS_QUEUE
  value: "pentest-{{ .type }}"
{{- end }}

{{/*
Create consumer name based on subject prefix and GPU specs.
*/}}
{{- define "dynamoai.natsGpuConsumerName" -}}
{{- printf "%s-gpu-%s-%d" .subjectprefix .type (int .count) | replace "." "-" | lower -}}
{{- end -}}

{{/*
Create consumer name based on subject prefix and GPU specs.
*/}}
{{- define "dynamoai.natsVramConsumerName" -}}
{{- printf "%s-vram-%d" .subjectprefix (int .type) | replace "." "-" | lower -}}
{{- end -}}


{{/*
Create subject filter for consumer based on GPU specs.
*/}}
{{- define "dynamoai.natsGpuConsumerSubjectFilter" -}}
{{- printf "%s.gpu.%s.%d" .subjectprefix .type (int .count) -}}
{{- end -}}

{{/*
Create subject filter for consumer based on GPU specs.
*/}}
{{- define "dynamoai.natsVramConsumerSubjectFilter" -}}
{{- printf "%s.vram.%s" .subjectprefix .type -}}
{{- end -}}
