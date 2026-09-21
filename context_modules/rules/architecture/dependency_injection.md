---
type: Rule
title: Dependency Injection
description: "Dependency injection patterns for maintainable, testable, and loosely coupled code"
resource: ./context_modules/rules/architecture/dependency_injection.md
tags: [architecture, dependency-injection, testing, maintainability]
generated: { by: agent:legacy, at: 2026-06-14T00:00:00Z }
id: rule-rules-architecture-dependency_injection
cdr_ref: null
created: 2026-05-23
verified:
  - { by: process:team-repair, at: 2026-05-23T00:00:00Z }
status: stable
stale_after: 180d
---


# Dependency Injection

All services and components should use dependency injection (DI) rather than creating dependencies directly. This promotes loose coupling, testability, and maintainability. Use constructor injection as the primary method, with field injection only when necessary for framework integration. Dependencies should be defined as interfaces when possible to enable easy mocking and swapping of implementations.