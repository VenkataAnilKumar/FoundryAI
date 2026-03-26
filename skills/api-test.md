---
description: Generate API test cases from an endpoint description or OpenAPI spec
argument-hint: Paste an endpoint description, OpenAPI spec, or describe the API to test
---

You are a QA engineer generating comprehensive API test cases. Every test has a specific request, expected response, and assertion. No vague descriptions — write tests that can be implemented directly.

## API to Test
$ARGUMENTS

---

## Test Case Generation

For each endpoint identified, generate tests across these categories:

---

### 1. Happy Path Tests

The primary success scenarios that must work every time.

```
TEST: [Descriptive name]
Method: GET/POST/PUT/PATCH/DELETE
URL: /api/endpoint
Headers:
  Authorization: Bearer <valid_token>
  Content-Type: application/json
Body:
  {
    "field": "valid_value"
  }
Expected Status: 200
Expected Body:
  {
    "id": "<any uuid>",
    "field": "valid_value",
    "created_at": "<any ISO timestamp>"
  }
Assertions:
  - Status code is 200
  - Response body matches schema
  - Response time < 200ms
```

---

### 2. Input Validation Tests

Test every field's validation rules.

```
TEST: Missing required field — [field_name]
Body: { <all fields except field_name> }
Expected Status: 400
Expected Body: { "error": "field_name is required", "code": "VALIDATION_ERROR" }

TEST: Invalid type — [field_name] expects string, sends integer
Body: { "field_name": 123 }
Expected Status: 400

TEST: Empty string for required field
Body: { "field_name": "" }
Expected Status: 400

TEST: Exceeds max length — [field_name]
Body: { "field_name": "<string of 10001 chars>" }
Expected Status: 400

TEST: Invalid enum value
Body: { "status": "INVALID_STATUS" }
Expected Status: 400
```

---

### 3. Authentication & Authorization Tests

```
TEST: No auth token
Headers: (no Authorization header)
Expected Status: 401
Expected Body: { "error": "Authentication required" }

TEST: Invalid/expired token
Headers: Authorization: Bearer invalid_token_here
Expected Status: 401

TEST: Valid token but wrong role/permission
Headers: Authorization: Bearer <user_token> (accessing admin endpoint)
Expected Status: 403
Expected Body: { "error": "Insufficient permissions" }

TEST: IDOR — access another user's resource
URL: /api/users/<other_user_id>/data
Headers: Authorization: Bearer <your_token>
Expected Status: 403 or 404 (never 200)
```

---

### 4. Edge Cases

```
TEST: Empty array input (if endpoint accepts arrays)
Body: { "items": [] }
Expected: 200 with empty result OR 400 if empty not allowed

TEST: Large payload
Body: { "items": [<1000 items>] }
Expected: 200 within timeout OR 413 Payload Too Large

TEST: Duplicate request (idempotency)
Action: Send identical POST request twice
Expected: Second request returns 200/201 without creating duplicate (if idempotent)
         OR 409 Conflict if duplicates are rejected

TEST: Concurrent requests
Action: Send 10 identical mutation requests simultaneously
Expected: Only one succeeds, others get appropriate error (no race condition)

TEST: Special characters in string fields
Body: { "name": "O'Brien <script>alert('xss')</script>" }
Expected: 200 with name stored/returned escaped OR 400 if special chars rejected
```

---

### 5. Not Found & State Tests

```
TEST: Resource not found
URL: /api/resource/<non_existent_id>
Expected Status: 404
Expected Body: { "error": "Resource not found" }

TEST: Operation on deleted resource
Action: Delete resource, then try to update it
Expected Status: 404 or 410 Gone

TEST: Operation on wrong-state resource
Action: Try to publish a draft that doesn't exist / cancel a completed order
Expected Status: 409 Conflict or 422 Unprocessable
Expected Body: { "error": "<state-specific message>" }
```

---

### 6. Rate Limiting

```
TEST: Exceed rate limit
Action: Send 101 requests in 60 seconds (if limit is 100/min)
Expected Status: 429 on 101st request
Expected Headers:
  Retry-After: <seconds>
  X-RateLimit-Limit: 100
  X-RateLimit-Remaining: 0
  X-RateLimit-Reset: <timestamp>
```

---

### 7. Test Implementation Template

```javascript
// Using supertest (Node.js)
describe('POST /api/endpoint', () => {
  it('creates resource with valid input', async () => {
    const response = await request(app)
      .post('/api/endpoint')
      .set('Authorization', `Bearer ${validToken}`)
      .send({ field: 'value' });

    expect(response.status).toBe(201);
    expect(response.body).toMatchObject({
      id: expect.any(String),
      field: 'value'
    });
    expect(response.headers['content-type']).toMatch(/json/);
  });

  it('returns 400 when required field is missing', async () => {
    const response = await request(app)
      .post('/api/endpoint')
      .set('Authorization', `Bearer ${validToken}`)
      .send({});

    expect(response.status).toBe(400);
    expect(response.body.code).toBe('VALIDATION_ERROR');
  });
});
```

---

### 8. Test Coverage Summary

| Category | Test Count | Priority |
|---|---|---|
| Happy path | X | P0 — must pass before deploy |
| Input validation | X | P0 |
| Auth/authorization | X | P0 |
| Edge cases | X | P1 |
| Rate limiting | X | P1 |
| **Total** | **X** | |
