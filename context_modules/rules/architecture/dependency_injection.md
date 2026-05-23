---
id: rule-rules-architecture-dependency_injection
cdr_ref: null
created: 2026-05-23
modified: 2026-05-23
verified: 2026-05-23
age_days: 0
evidence: []
---

# Dependency Injection

All services and components should use dependency injection (DI) rather than creating dependencies directly. This promotes loose coupling, testability, and maintainability. Use constructor injection as the primary method, with field injection only when necessary for framework integration. Dependencies should be defined as interfaces when possible to enable easy mocking and swapping of implementations.