---
type: Rule
title: Pre-Commit Security Checklist
description: Pre-commit security checklist to verify before submitting code
tags: [security, pre-commit, checklist, code-review]
timestamp: 2026-06-14T00:00:00Z
id: rule-rules-security-pre_commit_checklist
cdr_ref: CDR-2026-020
created: 2026-05-03
modified: 2026-06-14
verified: 2026-05-21
age_days: 42
evidence: []
---

# Rule: Pre-Commit Security Checklist

Run through this checklist before every commit to ensure security best practices are followed.

## Critical Checks (Must Pass)

### 1. No Hardcoded Secrets

- [ ] No API keys in source code
- [ ] No passwords in source code
- [ ] No tokens in source code
- [ ] No private keys in source code
- [ ] No database connection strings with credentials

**Verification:**
```bash
# Scan for common secret patterns
grep -r -E '(password|secret|token|key|api_key)\s*=\s*["\'][^"\']{8,}["\']' --include="*.py" --include="*.java" --include="*.js" --include="*.ts" .
```

**See also:** `@rule:devops/secrets_management.md` for proper secret handling patterns.

### 2. SQL Injection Prevention

- [ ] All database queries use parameterized queries
- [ ] No string concatenation in SQL queries
- [ ] ORM methods used where available

**See:** `@rule:security/sql_injection_prevention.md` for language-specific patterns.

### 3. Input Validation

- [ ] All user inputs validated at system boundaries
- [ ] Schema-based validation used where appropriate
- [ ] Input length and type constraints enforced
- [ ] Fail-fast with clear error messages

## High Priority Checks

### 4. XSS Prevention

- [ ] User-generated content is escaped before rendering
- [ ] HTML sanitization applied to rich text inputs
- [ ] Content Security Policy headers configured
- [ ] No direct DOM manipulation with user input

### 5. CSRF Protection

- [ ] CSRF tokens included in state-changing requests
- [ ] SameSite cookie attributes configured
- [ ] Origin/Referer headers validated for sensitive operations

### 6. Authentication & Authorization

- [ ] All endpoints properly authenticated (unless explicitly public)
- [ ] Authorization checks performed for resource access
- [ ] Principle of least privilege followed
- [ ] Session management secure (httponly, secure flags)

## Medium Priority Checks

### 7. Rate Limiting

- [ ] Rate limiting configured on all endpoints
- [ ] Different limits for authenticated vs unauthenticated users
- [ ] Burst handling configured appropriately

### 8. Error Handling

- [ ] Error messages don't leak sensitive data (stack traces, internal paths)
- [ ] Sensitive data not logged
- [ ] Generic error messages shown to users
- [ ] Detailed errors logged server-side only

### 9. Dependencies

- [ ] No vulnerable dependencies (run `npm audit`, `pip-audit`, etc.)
- [ ] Dependencies pinned to specific versions
- [ ] Minimal dependencies principle followed

## CI/CD Security

### 10. Pipeline Security

- [ ] No hardcoded credentials in workflow files
- [ ] OIDC used for cloud authentication (not long-lived credentials)
- [ ] Secrets referenced via secret stores, not environment variables

**See:** `@rule:devops/github_actions.md` for CI/CD security patterns including OIDC configuration.

## Language-Specific Validation

### Python

See `@rule:style-guides/python/pep8_and_docstrings.md` for input validation patterns.

### Java

See `@rule:style-guides/java/google_style_guide.md` and `@rule:style-guides/java/null_safety_and_optional.md` for validation patterns.

## Quick Reference

| Risk | Pattern | Safe Alternative |
|------|---------|------------------|
| Hardcoded secrets | `API_KEY = "abc123"` | Environment variables, secret managers |
| SQL injection | `f"SELECT * FROM users WHERE id = {user_id}"` | Parameterized queries, ORMs |
| XSS | `element.innerHTML = userInput` | `textContent`, HTML sanitization |
| CSRF | Missing tokens | CSRF tokens, SameSite cookies |
| Info leak | `return str(e)` | Generic messages, detailed server logs |

## References

- `@rule:security/sql_injection_prevention.md` - SQL injection prevention patterns
- `@rule:devops/secrets_management.md` - Kubernetes secrets management
- `@rule:devops/github_actions.md` - CI/CD security with OIDC
- `@rule:style-guides/python/pep8_and_docstrings.md` - Python validation
- `@rule:style-guides/java/google_style_guide.md` - Java validation
