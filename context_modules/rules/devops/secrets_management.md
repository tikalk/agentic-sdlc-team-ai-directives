# Secrets Management

**Rule Overview**: Comprehensive secrets management patterns for Kubernetes using External Secrets Operator and DRY principles.

**Rationale**: Secure credential management, automatic secret rotation, GitOps-friendly secret distribution, no secrets in Git history.

---

## Part 1: External Secrets Operator Patterns

### ExternalSecret CRD Structure

**Rule**: Use ExternalSecret CRD with proper spec configuration for secret synchronization

**Implementation**:
```yaml
# templates/externalSecret.yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: {{ include "chart.name" . }}
spec:
  refreshInterval: 10m
  secretStoreRef:
    name: {{ .Values.secretStore.name }}
    kind: {{ .Values.secretStore.kind | default "ClusterSecretStore" }}
  target:
    name: {{ include "chart.name" . }}
    creationPolicy: Owner
  data:
    {{- toYaml .Values.data | nindent 4 }}
  dataFrom:
    {{- toYaml .Values.dataFrom | nindent 4 }}
```

### Secret Store Configuration

**Rule**: Configure secret store reference (ClusterSecretStore or SecretStore) with proper kind

**Implementation**:
```yaml
# values.yaml
secretStore:
  name: aws-secrets-manager
  kind: SecretStore
```

### Data Mapping Pattern

**Rule**: Use `data` field for static key-value pairs and `dataFrom` for dynamic references

**Implementation**:
```yaml
# Static data
data:
  - secretKey: DATABASE_URL
    remoteRef:
      key: infra-database
      property: connection-url

# Dynamic data from other secret
dataFrom:
  - secretRef:
      name: postgres-credentials
      key: db-password
```

### Refresh Interval Configuration

**Rule**: Set appropriate refresh intervals based on secret sensitivity

```yaml
# High-frequency secrets (e.g., API keys): 1m
# Medium-frequency secrets (e.g., database passwords): 10m
# Low-frequency secrets (e.g., long-lived certificates): 1h
```

### Security Patterns

**Rule**: Use `creationPolicy: Owner` to ensure the chart/namespace owns the secret

**Rule**: Configure automatic secret rotation via external secret store capabilities

**Rule**: Exclude template files from secret synchronization

---

## Part 2: DRY Secrets Pattern

### Two-Pattern Approach

**Pattern 1: Local Development (secret: dictionary)**

Use for: Docker Desktop, minikube, kind

```yaml
# values.yaml
secret:
  DATABASE_URL: "database-url-key"
  API_KEY: "api-key-key"
  JWT_SECRET: "jwt-secret-key"
```

This generates `valueFrom.secretKeyRef` structures automatically.

**Pattern 2: Cloud Environments (externalSecretsKey:)**

Use for: EKS, GKE, AKS with cloud secrets manager

```yaml
# values-production.yaml
externalSecretsKey: "backoffice"
```

Single line that injects all keys from cloud secrets manager via `envFrom`.

### DRY Principles

- Never duplicate secret declarations - use single source pattern
- Automate secret management with task commands
- Cloud environments: Adding/removing secrets only requires cloud secrets manager updates (no values.yaml changes)
- Use standalone Helm templates for local pattern, External Secrets Operator for cloud pattern

### Standalone Helm Templates

```yaml
# templates/secrets-local.yaml
{{- if .Values.secret }}
{{- $secretName := .Values.secretName | default (include "chart.fullname" .) }}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
type: Opaque
data:
  {{- range $key, $value := .Values.secret }}
  {{ $key }}: {{ $value | b64enc | quote }}
  {{- end }}
{{- end }}
```

```yaml
# templates/external-secret.yaml
{{- if .Values.externalSecretsKey }}
{{- $secretName := .Values.secretName | default (include "chart.fullname" .) }}
{{- $secretStoreName := .Values.secretStoreName | default "cluster-secret-store" }}
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: {{ $secretName }}
spec:
  secretStoreRef:
    kind: ClusterSecretStore
    name: {{ $secretStoreName }}
  refreshInterval: {{ .Values.secretRefreshInterval | default "1m" }}
  target:
    name: {{ $secretName }}
    deletionPolicy: Delete
  dataFrom:
    - extract:
        key: {{ .Values.externalSecretsKey }}
{{- end }}
```

---

## Part 3: GKE Workload Identity Integration

### Workload Identity Setup

For GKE clusters, integrate with Workload Identity for keyless authentication:

```yaml
# ServiceAccount annotation
apiVersion: v1
kind: ServiceAccount
metadata:
  name: airflow-workers
  annotations:
    iam.gke.io/gcp-service-account: my-workflow-sa@project-id.iam.gserviceaccount.com
```

### Benefits

- No long-lived credentials needed
- Automatic token rotation
- Works with External Secrets Operator
- Follows zero trust security model

---

## Security Best Practices

- Never commit actual secret values to version control
- Use different secret stores for different environments
- Rotate secrets regularly using cloud provider tools
- Apply least-privilege access to secret stores
- Use OIDC for CI/CD authentication (see @rule:devops/github_actions.md)

---

## Related Rules

- See `@rule:devops/helm_packaging.md` for Helm packaging principles
- See `@rule:devops/helm_chart_library.md` for chart library patterns
- See `@rule:devops/github_actions.md` for OIDC authentication in CI/CD
- See `@rule:devops/gke_workload_identity.md` for GKE-specific patterns