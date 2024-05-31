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
{{- define "dynamoai.moderationEnv" -}}
- name: NUM_WORKERS
  value: "{{ .Values.moderation.numWorkers }}"
- name: K8_MODELS_NAMESPACE
  value: {{ .Release.Namespace }}
- name: LEGAL_ADVICE_MODEL
  value: "{{ .Values.models.legalAdvice.name }}"
- name: PROMPT_INJECTION_MODEL
  value: "{{ .Values.models.promptInjection.name }}"
- name: INPUT_TOXICITY_MODEL
  value: "{{ .Values.models.toxicity.name }}"
- name: DYNAMO_DATA_GENERATION_MODEL
  value: "{{ .Values.models.dataGeneration.name }}"
- name: DYNAMO_DATA_GENERATION_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: data_generation_api_key
- name: OTEL_METRIC_EXPORT_INTERVAL
  value: "10000"
{{- end }}

{{/*
Define environment variables specific to the Lorax service.
*/}}
{{- define "dynamoai.loraxEnv" -}}
- name: HF_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: hf_token
- name: PREDIBASE_MODEL_BUCKET
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: bucketName
{{- end }}


{{- define "dynamoai.moderation.resources" -}}
{{- $numWorkers := .Values.moderation.numWorkers -}}
resources:
  requests:
    cpu: {{ $numWorkers }}
    memory: {{ mul $numWorkers 2000 }}Mi
    ephemeral-storage: 10Gi
  limits:
    cpu: {{ mul $numWorkers 2 }}
    memory: {{ mul $numWorkers 2000 }}Mi
    ephemeral-storage: 20Gi
{{- end -}}

{{- define "dynamoai.hallucinationEntailment.resources" -}}
{{- $numWorkers := .Values.hallucinationEntailment.numWorkers -}}
resources:
  requests:
    cpu: {{ $numWorkers }}
    memory: {{ $numWorkers }}Gi
    ephemeral-storage: 10Gi
    nvidia.com/gpu: '1'
  limits:
    cpu: {{ mul $numWorkers 2 }}
    memory: {{ mul $numWorkers 2 }}Gi
    ephemeral-storage: 20Gi
    nvidia.com/gpu: '1'
{{- end -}}

{{- define "dynamoai.hallucinationEntailmentEnv" -}}
- name: NUM_WORKERS
  value: "{{ .Values.hallucinationEntailment.numWorkers }}"
{{- end }}

{{- define "dynamoai.hallucinationRag.resources" -}}
{{- $numWorkers := .Values.hallucinationRag.numWorkers -}}
resources:
  requests:
    cpu: {{ $numWorkers }}
    memory: {{ $numWorkers }}Gi
    ephemeral-storage: 10Gi
    nvidia.com/gpu: '1'
  limits:
    cpu: {{ mul $numWorkers 2 }}
    memory: {{ mul $numWorkers 2 }}Gi
    ephemeral-storage: 20Gi
    nvidia.com/gpu: '1'
{{- end -}}

{{- define "dynamoai.hallucinationRagEnv" -}}
- name: NUM_WORKERS
  value: "{{ .Values.hallucinationRag.numWorkers }}"
- name: MISTRAL_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: mistral_api_key
{{- end }}

{{- define "dynamoai.piiRedactionEnv" -}}
- name: K8_MODELS_NAMESPACE
  value: {{ .Release.Namespace }}
- name: HF_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: hf_token
{{- end }}

{{/*
Function to generate environment variables for VLLM.
*/}}

{{- define "dynamoai.generateVllmEnvVars" -}}
- name: MODEL_PATH
  value: {{ .modelNameOrPath | quote }}
- name: MODEL_NAME
  value: {{ default .modelNameOrPath .servedModelName | quote }}
- name: HF_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .secret }}
      key: hf_token
- name: NUM_GPUS
  value: {{ index .requests "nvidia.com/gpu" | quote }}
- name: MAX_MODEL_LEN
  value: "{{ .maxModelLength }}"
{{- end }}

{{- define "dynamoai.finetuningScaledJobEnv" -}}
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
{{- if .Values.global.awsRegion }}
- name: AWS_DEFAULT_REGION
  value: "{{ .Values.global.awsRegion }}"
{{- end }}
- name: MAX_REQUESTS_TO_PROCESS
  value: '1'
- name: REDIS_QUEUE
  value: "{{ .Values.finetuning.name }}"
- name: HF_TOKEN
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: hf_token
- name: MODEL_NAME_OR_PATH
  value: "{{ .Values.models.finetuning.path }}"
- name: S3_BUCKET_NAME
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: bucketName
{{- end }}

{{- define "dynamoai.dataProcessingEnv" -}}
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
{{- if .Values.global.awsRegion }}
- name: AWS_DEFAULT_REGION
  value: "{{ .Values.global.awsRegion }}"
{{- end }}
- name: MAX_REQUESTS_TO_PROCESS
  value: '10'
- name: REDIS_QUEUE
  value: "{{ .Values.dataProcessing.name }}"
- name: DYNAMO_DATA_GENERATION_MODEL
  value: "{{ .Values.models.dataGeneration.name }}"
- name: DYNAMO_DATA_GENERATION_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: data_generation_api_key
{{- end }}