---
instruction_type: Security
priority: Critical
description: Standards for preventing SQL injection vulnerabilities across all languages with language-specific examples
---

# Rule: Prevent SQL Injection

## Universal Checklist

- Always use parameterized queries or ORM query builders—never string interpolation.
- Validate and sanitize inputs at the boundary layer (API/controller).
- Enforce least privilege on database credentials; read-only where possible.
- Add regression tests covering malicious payloads (e.g., `' OR 1=1 --`).
- Never concatenate or interpolate strings in queries.

## Language-Specific Patterns

### Java

**Parameterization with PreparedStatement:**
```java
String sql = "SELECT * FROM users WHERE email = ? AND status = ?";
try (PreparedStatement stmt = connection.prepareStatement(sql)) {
    stmt.setString(1, email);
    stmt.setString(2, status);
    ResultSet rs = stmt.executeQuery();
    // ...
}
```

**JPA Named Parameters:**
```java
@Query("SELECT u FROM User u WHERE u.email = :email AND u.status = :status")
Optional<User> findByEmailAndStatus(@Param("email") String email,
                                   @Param("status") String status);
```

**JPA Positional Parameters:**
```java
@Query("SELECT u FROM User u WHERE u.email = ?1 AND u.status = ?2")
Optional<User> findByEmailAndStatus(String email, String status);
```

**Avoid - NEVER DO THIS:**
```java
// VULNERABLE - Never do this
String sql = "SELECT * FROM users WHERE email = '" + email + "'";
Statement stmt = connection.createStatement();
ResultSet rs = stmt.executeQuery(sql);
```

**Additional Java Guidelines:**
- When using Spring Data JPA, prefer method names or `@Query` with parameters over `@Query` with string interpolation.
- Validate and sanitize inputs at the controller/service boundary layer before database operations.
- Enforce least privilege on database credentials; use read-only connections where possible.
- Use database connection pooling with appropriate security configurations.
- Avoid dynamic query building; if necessary, use query builders (JPA Criteria API, QueryDSL) that handle parameterization.

### Python (PEP 8 Style)

**Using psycopg2 with parameterized queries:**
```python
# Good: Use parameterized queries
sql = "SELECT * FROM users WHERE email = %s AND status = %s"
cursor.execute(sql, (email, status))
```

**Using SQLAlchemy ORM:**
```python
# Good: Use SQLAlchemy ORM query
result = session.query(User).filter(
    User.email == email,
    User.status == status
).first()
```

**Avoid - NEVER DO THIS:**
```python
# VULNERABLE - Never do this
sql = f"SELECT * FROM users WHERE email = '{email}'"
cursor.execute(sql)
```

### JavaScript/Node.js

**Using parameterized queries with node-postgres:**
```javascript
// Good: Use parameterized queries
const result = await client.query(
  'SELECT * FROM users WHERE email = $1 AND status = $2',
  [email, status]
);
```

**Using an ORM (Sequelize/Prisma):**
```javascript
// Good: Use ORM methods
const user = await User.findOne({
  where: { email, status }
});
```

**Avoid - NEVER DO THIS:**
```javascript
// VULNERABLE - Never do this
const sql = `SELECT * FROM users WHERE email = '${email}'`;
```

### SQL Testing Payloads for Regression Tests

Include these in regression test suites:
- `' OR 1=1 --` (classic tautology)
- `'; DROP TABLE users; --` (table destruction)
- `UNION SELECT * FROM passwords--` (data exfiltration)
- `'; EXEC xp_cmdshell('dir'); --` (xp_cmdshell injection)

## Rationale

SQL injection remains a top OWASP risk. Following these patterns ensures every query is safe by construction, regardless of language or framework.

## References

- See `@rule:framework/spring_boot_patterns.md` for Spring Data JPA patterns
- See `@rule:style-guides/python_pep8_and_docstrings.md` for Python style