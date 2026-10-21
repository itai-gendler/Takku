---
appliesTo:
- type: capability
  id: edit-summary-profile
- type: capability
  id: test-connection
- type: capability
  id: process-meeting
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProviderProfile.swift#ProviderProfile.validatedBaseURL
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# A Profile's base URL uses https://, or http:// only for a server on this Mac

`localhost`, `127.0.0.1` and `::1` may use plain http; any other address must use https, even on the local network. A Profile whose address breaks this sends nothing, for a Summary or a *Test connection*.

## Rationale

Over plain http the key and the Transcript would travel readable.
