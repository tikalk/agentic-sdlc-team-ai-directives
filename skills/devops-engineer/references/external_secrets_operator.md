# External Secrets Operator Reference

See @rule:devops/external_secrets_operator.md for complete External Secrets Operator patterns.

## Key Patterns Summary

### ExternalSecret CRD Structure
- Use ExternalSecret CRD with proper spec configuration
- Configure secret store references (ClusterSecretStore or SecretStore)
- Set appropriate refresh intervals based on secret sensitivity

### Data Mapping Patterns
- Use `data` field for static key-value pairs
- Use `dataFrom` for dynamic secret references
- Support multiple secrets in single ExternalSecret

### Security Patterns
- Use `creationPolicy: Owner` for proper ownership
- Implement automatic secret rotation
- Exclude template files from secret synchronization

### Common Patterns
- Multiple secrets in single ExternalSecret
- Consistent naming conventions
- Proper secret store configuration

### Troubleshooting
- Verify secret creation with kubectl commands
- Monitor ExternalSecret status
- Check operator logs for debugging