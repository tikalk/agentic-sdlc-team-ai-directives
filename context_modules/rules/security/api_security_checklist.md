---
type: Rule
title: API Security Checklist
description: Checklist of API security best practices covering authentication, access control, input validation, output handling, JWT, OAuth, processing, and monitoring
tags: [security, api, authentication, oauth, jwt, checklist]
timestamp: "2026-08-06T00:00:00Z"
id: rule-rules-security-api_security_checklist
cdr_ref: CDR-2026-031
created: 2026-08-05
modified: 2026-08-05
verified: 2026-08-06
age_days: 0
evidence: []
---


# Rule: API Security Checklist

Run through this checklist when designing, building, or reviewing any API. This complements `@rule:security/pre_commit_checklist.md` with API-specific concerns (authentication schemes, JWT/OAuth, output hardening, and monitoring).

## 1. Authentication

- [ ] Avoid Basic Authentication — use standard mechanisms (e.g., JWT)
- [ ] Do not reinvent the wheel in authentication mechanisms — use well-established libraries/standards
- [ ] Use "max retry" and jail/lockout features on login endpoints
- [ ] Use encryption on all sensitive data

## 2. Access Control

- [ ] Limit requests (throttling) to avoid DDoS / brute-force attacks
- [ ] Use HTTPS on the server side with secure ciphers
- [ ] Use the HSTS header with SSL to avoid SSL-strip attacks
- [ ] Turn off directory listings
- [ ] Private APIs should only be accessible from safe-listed IPs

## 3. Input Validation & Control

- [ ] Limit requests (throttling) to avoid DDoS / brute-force attacks
- [ ] Use HTTPS on the server side with secure ciphers
- [ ] Use the HSTS header with SSL to avoid SSL-strip attacks
- [ ] Turn off directory listings
- [ ] Private APIs should only be accessible from safe-listed IPs

**See also:** `@rule:security/pre_commit_checklist.md` (Input Validation) and `@rule:security/sql_injection_prevention.md` for input-handling patterns.

## 4. Output & Data Leakage

- [ ] Send `X-Content-Type-Options: nosniff` header
- [ ] Send `X-Frame-Options: deny` header
- [ ] Send `Content-Security-Policy: default-src 'none'` header
- [ ] Remove fingerprinting headers (e.g., `X-Powered-By`)
- [ ] Force `Content-Type` for your response
- [ ] Avoid returning sensitive data (credentials, tokens, internal IDs)
- [ ] Return proper status/response codes matching the operation

## 5. JSON Web Tokens (JWT)

- [ ] Use strong JWT secrets to make brute-force key attacks difficult
- [ ] Do not extract or trust the algorithm from the incoming header; enforce it strictly on the backend
- [ ] Keep token expiration (TTL, RTTL) as short as possible
- [ ] Avoid storing sensitive data inside the JWT payload
- [ ] Keep the payload small to reduce overall JWT overhead

## 6. OAuth

- [ ] Always validate `redirect_uri` strictly on the server side
- [ ] Avoid `response_type=token` (implicit flow); exchange authorization codes for tokens instead
- [ ] Use the `state` parameter to prevent CSRF attacks
- [ ] Enforce default scopes and validate requested scopes per application

## 7. Processing

- [ ] Ensure all endpoints are protected behind authentication to prevent broken authorization flaws
- [ ] Avoid exposing user personal IDs directly in resource URLs (e.g., `/users/242/orders`)
- [ ] Prefer UUIDs over auto-increment sequential IDs
- [ ] Disable entity parsing when parsing XML to prevent XXE (XML External Entity) attacks
- [ ] Disable entity expansion in XML, YAML, or similar parsers (Billion Laughs protection)
- [ ] Use a CDN for file uploads
- [ ] Avoid HTTP blocking

## 8. Monitoring & Logging

- [ ] Use centralized logging for all services and infrastructure components
- [ ] Use monitoring agents to track requests, responses, and errors
- [ ] Configure real-time alerts via SMS, Slack, Email, Kibana, CloudWatch, etc.
- [ ] Ensure sensitive data is strictly masked/redacted before logging
- [ ] Deploy an IDS (Intrusion Detection System) and/or IPS (Intrusion Prevention System)

## References

- `@rule:security/pre_commit_checklist.md` - general pre-commit security checklist
- `@rule:security/sql_injection_prevention.md` - SQL injection prevention patterns
- `@rule:devops/secrets_management.md` - secrets and credential management
- `@rule:devops/github_actions.md` - CI/CD security with OIDC
- `@rule:performance/backend_performance_checklist.md` - rate limiting and throttling overlap with performance concerns
