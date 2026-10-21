---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/Settings/VocabularySection.swift#VocabularySection
- kind: code
  role: implementation
  target: Takku/Settings/TakkuFolder.swift#TakkuFolder.ensureVocabularyFile
- kind: adr
  role: intent
  target: docs/adr/0005-vocabulary-without-llm-pass-or-engine-biasing.md
---

# Edit vocabulary

*Edit Vocabulary With* in *Settings → Vocabulary* opens `~/.takku/vocabulary.md` in one of the Mac's editors, creating it with an example first if it is missing. The section shows how many terms Takku read, so a line written in the wrong format shows by its term missing.
