# Helm Chart Library Reference

See @rule:devops/helm_chart_library.md for complete Helm chart library patterns.

## Key Patterns Summary

### Library Chart Structure
- Create Helm library charts with `type: library`
- Use `lib.` prefix for all library template names
- Define helper functions in `templates/_helpers.yaml`
- Application charts depend on library via Chart.yaml

### Template Composition
- Use `include` to compose resources from library templates
- Follow "smallest possible values.yaml" philosophy
- Calculate derived values in templates, not in values files

### Common Templates
- `lib.deployment.tpl` - Deployment resource generation
- `lib.service.tpl` - Service resource generation
- `lib.env` - Environment variable management
- `lib.labels` - Standard Kubernetes labels

### Best Practices
- Single responsibility for each template
- Composable templates that work together
- Document all template parameters
- Test templates with various value combinations