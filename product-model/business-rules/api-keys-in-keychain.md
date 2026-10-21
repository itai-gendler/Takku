---
appliesTo:
- type: capability
  id: save-api-key
- type: capability
  id: remove-api-key
- type: capability
  id: delete-summary-profile
- type: entity
  id: summary-profile
  facts:
  - API key
references:
- kind: code
  role: implementation
  target: Takku/Settings/Keychain.swift#Keychain
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# API keys are kept only in the macOS Keychain

A Profile's key is saved under the Profile in the Keychain, never in files or settings, and deleted with the Profile. The editor shows only its last four characters.
