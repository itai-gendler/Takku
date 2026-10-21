---
domain: summary-profiles
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProviderProfile.swift#ProviderProfile
- kind: code
  role: implementation
  target: Takku/Settings/Keychain.swift#Keychain
- kind: doc
  role: context
  target: CONTEXT.md
---

# Summary Profile

A named configuration of an OpenAI-compatible Provider that writes Summaries: a server on this Mac or a remote one.

## Information kept

- **Name** — Shown in the menu; *Untitled* while empty.
- **Base URL** — The Provider's OpenAI-compatible address.
- **Model** — The model asked for the Summary.
- **Max context** — The tokens the model accepts in one request; never less than 8,192 is used.
- **Reasoning** — Model default, Off, Low, Medium or High.
- **Extra parameters** — A JSON object added to every request of the Profile.
- **API key** — Kept in the macOS Keychain, shown by its last four characters; optional for servers on this Mac.
