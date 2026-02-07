# GKE Workload Identity Reference

See @rule:devops/gke_workload_identity.md for complete GKE Workload Identity patterns.

## Key Patterns Summary

### Service Account Annotation
- Annotate Kubernetes ServiceAccounts with Workload Identity
- Map KSA to Google Service Account for authentication
- Use `iam.gke.io/gcp-service-account` annotation

### Workload Identity Usage
- Use annotated ServiceAccounts in pod specifications
- Implement IAM bindings for proper access control
- Enable automatic token management

### Authentication Benefits
- Eliminates need for GCP service account keys
- Provides automatic credential rotation
- Enables keyless authentication
- Follows security best practices

### Implementation Patterns
- ServiceAccount annotation for authentication
- Pod service account reference
- Values configuration for Helm charts

### Security Advantages
- No manual key management
- Automatic token renewal
- Secure authentication method
- GitOps-friendly approach