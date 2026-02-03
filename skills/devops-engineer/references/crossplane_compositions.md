# Crossplane Compositions Reference

See @rule:devops/crossplane_compositions.md for complete Crossplane composition patterns.

## Key Patterns Summary

### Composition Structure
- Create CompositeResourceDefinitions (XRDs) for custom resource types
- Define Composition resources for infrastructure patterns
- Use Patch and Transform (P&T) for resource composition
- Store compositions in Git for version control

### Generic Resource Patterns
- Define base resources using provider-specific APIs
- Use provider-agnostic resource definitions
- Implement proper credential management
- Maintain cloud provider flexibility

### Patch and Transform
- Use `spec.resources[].patches` for field mapping
- Apply transforms for complex field conversions
- Chain multiple transforms for advanced mappings
- Use appropriate patch policies (Merge, Replace)

### Composition Functions
- Use Functions for complex logic beyond P&T
- Package Functions as OCI images
- Chain Functions in pipelines for sequential processing
- Handle external API calls and validations

### Best Practices
- Abstract cloud provider specifics
- Create reusable infrastructure patterns
- Test compositions in non-production environments
- Document all composition patterns and usage