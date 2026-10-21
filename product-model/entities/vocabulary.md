---
singleton: true
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Vocabulary.swift#Vocabulary
- kind: adr
  role: intent
  target: docs/adr/0005-vocabulary-without-llm-pass-or-engine-biasing.md
- kind: doc
  role: context
  target: CONTEXT.md
---

# Vocabulary

The file `~/.takku/vocabulary.md` listing the names, acronyms and technical words recognition gets wrong. It applies to every Meeting.

## Information kept

- **Entries** — One per `- ` line: the correct term, the variants usually heard instead after `=`, and a short description after `|`; for a repeated term or variant the first one counts.
