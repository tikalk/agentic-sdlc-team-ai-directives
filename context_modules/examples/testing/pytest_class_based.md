---
type: Example
title: Class-Based Pytest Suite
description: Example of class-based pytest test structure for Python services
tags: [python, testing, pytest, class-based, example]
timestamp: 2026-06-14T00:00:00Z
id: example-examples-testing-pytest_class_based
cdr_ref: null
created: 2026-05-23
modified: 2026-06-14
verified: 2026-05-23
age_days: 22
evidence: []
---

# Example: Class-Based Pytest Suite

```python
import pytest


class TestCustomerSerializer:
    def test_valid_payload(self, serializer_factory):
        serializer = serializer_factory(
            "CustomerSerializer",
            data={"email": "alex@example.com", "status": "active"},
        )

        assert serializer.is_valid(), serializer.errors
        assert serializer.validated_data["status"] == "active"

    def test_missing_email(self, serializer_factory):
        serializer = serializer_factory("CustomerSerializer", data={"status": "active"})

        assert not serializer.is_valid()
        assert "email" in serializer.errors


@pytest.fixture
def serializer_factory():
    def make(class_name, **kwargs):
        module = __import__("app.serializers", fromlist=[class_name])
        serializer_cls = getattr(module, class_name)
        return serializer_cls(**kwargs)

    return make
```

**Why it works**

- Uses class-based tests to group related behaviors.
- Keeps fixtures reusable for other serializer suites.
- Demonstrates assertion patterns Agents can emulate when creating new tests.
