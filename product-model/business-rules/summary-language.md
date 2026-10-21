---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: retry-meeting
- type: entity
  id: template
  facts:
  - Summary language
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/SummaryPrompt.swift#SummaryPrompt.summaryLanguage
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# The Summary is written in the Template's language, else in the Meeting's

A Template's `summary_language` wins; without it, or with `auto`, the Summary follows the Meeting's detected language, and Italian when no language was detected. The title is written in the same language. The structure Takku writes into the Vault is always in English.
