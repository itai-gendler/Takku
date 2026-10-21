---
availability:
- place: takku
domain: summary-profiles
references:
- kind: code
  role: implementation
  target: Takku/Settings/ProfileEditor.swift#ProfileEditor.saveKey
- kind: code
  role: implementation
  target: Takku/Settings/Keychain.swift#Keychain.setAPIKey
---

# Save API key

The *API key* field of a Profile saves a pasted key in the macOS Keychain, on Return or with *Save key*, never while typing.
