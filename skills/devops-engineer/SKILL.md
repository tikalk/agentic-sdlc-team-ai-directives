---
name: devops-engineer
description: DevOps engineering patterns for infrastructure automation, CI/CD pipelines, Kubernetes deployments, and cloud operations. Use when setting up DevOps workflows, managing infrastructure as code, or implementing secure deployment practices.
---

# DevOps Engineer

## What This Skill Provides

DevOps engineering patterns and best practices for:
- Infrastructure automation and management
- CI/CD pipeline implementation
- Kubernetes deployment patterns
- Cloud operations and security
- Secret management and authentication

## When to Use This Skill

- Setting up DevOps workflows and automation
- Managing infrastructure as code
- Implementing secure deployment practices
- Designing cloud-native architectures
- Establishing observability and monitoring

## Core DevOps Patterns

### Infrastructure as Code

**Rule**: Use declarative infrastructure management for all resources

**Implementation Summary**:
- Use Crossplane for cloud-agnostic infrastructure
- Implement Helm chart libraries for Kubernetes resources
- Follow GitOps workflows for infrastructure changes
- Version control all infrastructure configurations

**References**: See references/helm_chart_library.md, references/crossplane_compositions.md

### CI/CD Pipeline Automation

**Rule**: Implement automated build, test, and deployment pipelines

**Implementation Summary**:
- Use GitHub Actions for pipeline automation
- Implement reusable workflows and actions
- Use OIDC for cloud authentication (no long-lived credentials)
- Configure proper permissions and security controls

**References**: See references/github_actions.md

### Secret Management

**Rule**: Use secure secret management with no secrets in source control

**Implementation Summary**:
- Use External Secrets Operator for Kubernetes secrets
- Implement cloud-native secret managers (AWS Secrets Manager, etc.)
- Use GKE Workload Identity for GCP authentication
- Follow zero-trust security principles

**References**: See references/external_secrets_operator.md, references/gke_workload_identity.md

### Security and Compliance

**Rule**: Implement security by default with least privilege access

**Implementation Summary**:
- Use OIDC for cloud provider authentication
- Implement proper RBAC and permissions
- Follow zero-trust security model
- Encrypt all data in transit and at rest

**References**: See references/gke_workload_identity.md, references/external_secrets_operator.md

## Integration with Team Constitution

### Principle 2 (Build for Observability)
- Implement comprehensive monitoring and logging
- Use structured logging for troubleshooting
- Set up alerting for critical systems

### Principle 3 (Security by Default)
- Use least privilege for all access
- Validate all inputs and configurations
- Prefer managed security services

### Principle 4 (Tests Drive Confidence)
- Test infrastructure changes in non-production
- Implement automated security scanning
- Validate deployment processes

### Principle 7 (Zero Trust Security Model)
- Verify and authenticate all requests
- Implement least privilege access
- Continuously monitor for threats

## Workflow Patterns

### GitOps Implementation
- Store infrastructure configurations in Git
- Use automated deployment from Git changes
- Implement proper review processes for changes
- Maintain audit trails for all changes

### Deployment Strategies
- Use blue-green or canary deployments
- Implement rollback procedures
- Test deployments in staging environments
- Monitor deployment success and rollback if needed

### Monitoring and Observability
- Implement comprehensive logging
- Set up metrics collection and alerting
- Use distributed tracing for debugging
- Monitor system health and performance

## References

- **Helm Chart Library**: See references/helm_chart_library.md for Kubernetes resource patterns
- **External Secrets Operator**: See references/external_secrets_operator.md for secret management
- **GitHub Actions**: See references/github_actions.md for CI/CD automation
- **GKE Workload Identity**: See references/gke_workload_identity.md for GCP authentication
- **Crossplane Compositions**: See references/crossplane_compositions.md for infrastructure as code

## Best Practices

- Automate everything possible
- Use infrastructure as code for all resources
- Implement proper security controls
- Test all changes in non-production
- Monitor and observe all systems
- Document all processes and decisions