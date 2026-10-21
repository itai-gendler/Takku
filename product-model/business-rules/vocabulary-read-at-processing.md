---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: retry-meeting
- type: capability
  id: edit-vocabulary
- type: entity
  id: vocabulary
references:
- kind: adr
  role: intent
  target: docs/adr/0005-vocabulary-without-llm-pass-or-engine-biasing.md
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Vocabulary.swift#Vocabulary.variantReplacer
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# The Vocabulary in effect is the one read when Processing starts

A change counts from the next Meeting, or from a Retry. Its variants are replaced with their term in the Transcript as whole words, ignoring case, the longest first; every entry goes to the Summary prompt. Recognition gets nothing, and a Regeneration does not change the Transcript's text.
