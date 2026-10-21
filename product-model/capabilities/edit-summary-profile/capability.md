---
availability:
- place: takku
domain: summary-profiles
references:
- kind: code
  role: implementation
  target: Takku/Settings/ProfileEditor.swift#ProfileEditor
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ExtraParameters.swift#ExtraParameters.parse
- kind: adr
  role: intent
  target: docs/adr/0009-reasoning-in-two-dialects-and-extra-parameters.md
---

# Edit summary profile

The selected Profile's editor: name, base URL, model, Max context, Reasoning and Extra parameters, saved as they are typed.
