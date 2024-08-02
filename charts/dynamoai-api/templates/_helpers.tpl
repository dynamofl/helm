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
- name: KEYCLOAK_DB_HOST
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: host
- name: KEYCLOAK_DB_NAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: keycloakDbName
- name: KEYCLOAK_DB_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: username
- name: KEYCLOAK_DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: password
- name: KEYCLOAK_DB_PORT
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.postgres }}
      key: port
- name: IS_KEYCLOAK_ENABLED
  value: {{ if eq .Values.api.authProvider "keycloak" }}"true"{{ else }}"false"{{ end }}
{{- end }}
{{- define "dynamoai.apiEnv" -}}
- name: PROJECTS_BUCKET
  value: dynamofl-projects
- name: PORT
  value: "{{ .Values.api.port }}"
- name: IS_AUDIT_LOGGING_ENABLED
  value: "true"
{{ include "dynamoai.dbMigrationsJobEnv" . }}
{{- if .Values.api.natsEnv.enabled }}
- name: NATS_ENABLED
  value: "true"
- name: NATS_SERVER
  value: {{ .Values.api.natsEnv.serverUrl }}
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
- name: OPENAI_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: openai_api_key
- name: DEFAULT_USER_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: default_user_password
- name: DEFAULT_USER_EMAIL
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: default_user_email
- name: DEFAULT_USER_API_KEY
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: default_user_api_key
- name: PLATFORM_ADMIN_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: platform_admin_password
- name: LICENSE
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: license
- name: SERVICE_USER_API_KEY_MAP
  valueFrom:
    secretKeyRef:
      name: {{ .Values.global.secrets.common }}
      key: service_user_api_key_map
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
- name: TEST_REPORT_GENERATION_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: testReportGenerationEnabled
- name: REMOTE_MODEL_CONFIG_VALIDATION_API_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: remoteModelConfigValidationApiEnabled
- name: HUGGINGFACE_API_REQUESTS_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: huggingfaceApiRequestsEnabled
- name: RATE_LIMIT_DYNAMO_GUARD
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: rateLimitDynamoGuard
- name: RATE_LIMIT_DYNAMO_EVAL
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: rateLimitDynamoEval
- name: PBAC_SAFETY_MODE_ENABLED
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: pbacSafetyModeEnabled
- name: COGNITO_USER_POOL_ID
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: cognitoUserPoolId
- name: COGNITO_CLIENT_ID
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: cognitoClientId
- name: PENTEST_BUCKET
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: bucketName
- name: CORS_RULE
  valueFrom:
    configMapKeyRef:
      name: {{ .Values.global.config.common }}
      key: corsRule
- name: AWS_DEFAULT_REGION
  value: "{{ .Values.global.awsRegion }}"
- name: MODERATOR_WORKER_ASYNC_ENDPOINT
  value: "{{ include "dynamoai.fullname" . }}-moderation.{{ if and .Values.global.dynamoguardnamespace (ne .Values.global.dynamoguardnamespace "") }}{{ .Values.global.dynamoguardnamespace }}{{ else }}{{ .Release.Namespace }}{{ end }}.svc.cluster.local:2344"

{{- end }}

{{- define "dynamoai.init.apiEnv" -}}
{
  {{- if .Values.dbMigrationsJob }}
  "pgDB": {
    "host": "$(PG_DB_HOST)",
    "user": "$(PG_DB_USERNAME)",
    "password": "$(PG_DB_PASSWORD)",
    "database": "$(PG_DB_NAME)",
    "port": "$(PG_DB_PORT)",
    "dbMigrationJobName": "{{ .Values.dbMigrationsJob.name }}",
    "namespace": "$(NAMESPACE)"
  },
  {{- end }}
  {{- if .Values.api.keycloakEnv }}
  "keycloak": {
    "baseUrl": "{{- range .Values.api.keycloakEnv }}{{ if eq .name "KEYCLOAK_BASE_URL" }}{{ .value }}{{ end }}{{- end }}"
  }
  {{- end }}
}
{{- end }}