# Contributing Guidelines

## Development Process

1. Create an issue using the templates
2. Create a feature branch
3. Implement changes
4. Test locally with `azd provision --preview`
5. Create pull request
6. Wait for automated validation
7. Merge after approval

## Issue Templates

Use the provided issue templates for:
- Adding new Azure services
- Modifying existing infrastructure  
- Security improvements
- Cost optimization

## Testing

Before submitting a PR:

```powershell
# Validate Bicep syntax
az bicep build --file infra/main.bicep

# Preview deployment
azd provision --preview --environment development
```

## Checklist

- [ ] Bicep files pass validation
- [ ] Parameters are properly defined
- [ ] RBAC permissions documented
- [ ] Costs estimated
- [ ] Security best practices followed
- [ ] Documentation updated
