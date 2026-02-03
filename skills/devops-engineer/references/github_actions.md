# GitHub Actions Reference

See @rule:devops/github_actions.md for complete GitHub Actions patterns.

## Key Patterns Summary

### Reusable Workflows
- Create organization-level reusable workflows
- Use `workflow_call` trigger for invoking reusable workflows
- Version reusable workflows using Git tags or commit SHAs
- Structure workflows by function (build, test, deploy)

### Workflow Organization
- Group related workflows in subdirectories
- Use descriptive workflow names
- Create base workflows for common patterns
- Use workflow composition for complex pipelines

### Security Best Practices
- Always use OIDC for cloud provider authentication
- Configure minimal required permissions
- Use GitHub secrets for environment-specific configuration
- Implement proper concurrency controls

### Common Patterns
- Reusable workflows and composite actions
- Organization-level workflow sharing
- Proper input/output handling
- Backward compatibility maintenance

### Cost Control
- Implement job timeouts and resource limits
- Use concurrency groups to prevent duplicate runs
- Optimize workflow execution time
- Monitor workflow costs