---
type: Rule
title: Backend Performance Checklist
description: Checklist of backend performance best practices covering caching, databases, security, network, API response, asynchronism, scaling, and code optimization
tags: [performance, backend, database, caching, scaling, checklist]
timestamp: 2026-08-05T00:00:00Z
id: rule-rules-performance-backend_performance_checklist
cdr_ref: CDR-2026-030
created: 2026-08-05
modified: 2026-08-05
verified: 2026-08-05
age_days: 0
evidence: []
---

# Rule: Backend Performance Checklist

Run through this checklist when building or reviewing backend services, APIs, and data access layers. Items are grouped by concern rather than strict priority — apply the ones relevant to your service's architecture.

For frontend/transport-level performance, see `@rule:performance/frontend_performance_checklist.md`. For database-specific patterns, see `@rule:data/spring_boot_patterns.md` where applicable.

## 1. Caching

- [ ] Utilize caching mechanisms (HTTP, server/client, CDN)
- [ ] Use cache-aside, write-through, or read-through caching patterns based on your application requirements
- [ ] Use proper cache-invalidation strategies to ensure data consistency and prevent stale content

## 2. Databases

- [ ] Use connection pooling to reduce connection overhead
- [ ] Fine-tune connection pool settings (e.g., max connections, idle timeout, connection reuse params) to optimize resource utilization and prevent connection exhaustion
- [ ] Create efficient database indexes
- [ ] Keep an eye on and fine-tune ORM queries
- [ ] Utilize lazy loading, eager loading, and batch processing to optimize data retrieval
- [ ] Implement efficient pagination for large datasets
- [ ] Avoid `SELECT *` queries — fetch only required columns
- [ ] Consider denormalizing schema for read-heavy workloads and reducing JOIN operations
- [ ] Optimize JOIN operations and avoid unnecessary joins
- [ ] Regularly clean up unused data and perform maintenance tasks like vacuuming, indexing, and optimizing queries
- [ ] Enable slow-query logging and monitor it
- [ ] Set up database replication for redundancy and improved read performance
- [ ] Use DB sharding for data distribution if required
- [ ] Use profiling tools offered by your database

## 3. Security

- [ ] Keep your dependencies up to date
- [ ] Implement proper authentication and authorization to prevent unauthorized access
- [ ] Implement request throttling and rate limiting
- [ ] Regularly audit and update security measures

**See also:** `@rule:security/pre_commit_checklist.md` for a broader security checklist.

## 4. Network

- [ ] Minimize network latency by hosting your backend close to your users
- [ ] Utilize HTTP keep-alive to reduce connection overhead
- [ ] Use CDNs for static and frequently accessed assets
- [ ] Prefetch or preload resources, data, or dependencies needed for subsequent requests to minimize latency

## 5. Optimize API Response

- [ ] Enforce reasonable payload size limits
- [ ] Enable compression for responses
- [ ] Implement efficient pagination for large datasets
- [ ] Minimize unnecessary processing or expensive computation on the server

## 6. Asynchronism

- [ ] Offload heavy tasks to background jobs or queues
- [ ] Utilize message brokers for asynchronous communication between services

## 7. Load Balancing & Scaling

- [ ] Use horizontal or vertical scaling, whichever is appropriate for the workload
- [ ] Use load balancing to distribute traffic across servers

## 8. Code Optimization

- [ ] Implement streaming for large requests/responses instead of buffering the full payload in memory

## References

- `@rule:performance/frontend_performance_checklist.md` - frontend/transport-level performance checklist
- `@rule:security/pre_commit_checklist.md` - security checklist (rate limiting, auth, dependency hygiene)
- `@rule:devops/secrets_management.md` - secrets management for database and service credentials
- `@rule:orchestration/airflow_dag_patterns.md` - patterns for offloading heavy/batch tasks
