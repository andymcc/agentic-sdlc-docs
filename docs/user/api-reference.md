# API Reference

Generated from `docs/api/openapi.yaml`. Do not edit manually.

## Endpoints

### GET /healthz

Health check.
Returns the health status of the service.

**Response 200** — Service is healthy.

```json
{
  "status": {
    "type": "string",
    "example": "ok"
  }
}
```
