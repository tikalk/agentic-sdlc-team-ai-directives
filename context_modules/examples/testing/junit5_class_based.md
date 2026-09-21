---
type: Example
title: Class-Based JUnit 5 Test Suite
description: Example of class-based JUnit 5 test structure with Mockito extension
resource: ./context_modules/examples/testing/junit5_class_based.md
tags: [java, testing, junit5, class-based, example]
generated: { by: agent:legacy, at: 2026-06-14T00:00:00Z }
id: example-examples-testing-junit5_class_based
cdr_ref: null
created: 2026-05-23
verified:
  - { by: process:team-repair, at: 2026-05-23T00:00:00Z }
status: stable
stale_after: 180d
---


# Example: Class-Based JUnit 5 Test Suite

```java
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@DisplayName("CustomerService Tests")
class CustomerServiceTest {
    
    @Mock
    private CustomerRepository customerRepository;
    
    private CustomerService customerService;
    
    @BeforeEach
    void setUp() {
        customerService = new CustomerService(customerRepository);
    }
    
    @Test
    @DisplayName("Should create customer with valid data")
    void shouldCreateCustomerWithValidData() {
        Customer customer = new Customer("alex@example.com", "active");
        when(customerRepository.save(any(Customer.class))).thenReturn(customer);
        
        Customer result = customerService.createCustomer(customer);
        
        assertNotNull(result);
        assertEquals("active", result.getStatus());
        assertEquals("alex@example.com", result.getEmail());
    }
    
    @Test
    @DisplayName("Should throw exception when email is missing")
    void shouldThrowExceptionWhenEmailIsMissing() {
        Customer customer = new Customer(null, "active");
        
        assertThrows(IllegalArgumentException.class, 
            () -> customerService.createCustomer(customer));
    }
}
```

**Why it works**

- Uses JUnit 5 with `@Mock` and `MockitoExtension` for clean dependency injection.
- Demonstrates `@DisplayName` for readable test output.
- Shows assertion patterns (assertNotNull, assertEquals, assertThrows) that Agents can emulate.
- Follows Arrange-Act-Assert (AAA) pattern for clear test structure.

