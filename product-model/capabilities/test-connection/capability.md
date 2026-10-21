---
availability:
- place: takku
domain: summary-profiles
references:
- kind: code
  role: implementation
  target: Takku/Settings/ProfileEditor.swift#ProfileEditor.test
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ChatClient.swift#ChatClient.complete
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProviderProfile.swift#ProviderProfile.validatedBaseURL
---

# Test connection

*Test connection* sends the Profile a short request, with the same Reasoning and Extra parameters as a Summary, so a value the model refuses shows while the Profile is set up.
