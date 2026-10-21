---
appliesTo:
- type: capability
  id: add-summary-profile
- type: capability
  id: change-summary-profile
references:
- kind: code
  role: implementation
  target: Takku/Settings/SettingsView.swift#SettingsView.addProfile
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# A new Profile is not used until the User chooses it

*Add Profile* leaves the menu on the Profile it used before, or Transcript.

## Rationale

An empty Profile in use would make every Meeting fail until it is filled in.
