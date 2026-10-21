---
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Transcript.swift#Transcript
- kind: code
  role: implementation
  target: Takku/Vault/Vault.swift#Vault.writeTranscript
- kind: doc
  role: context
  target: CONTEXT.md
---

# Transcript

The spoken text of a Meeting in its own file in `Meetings/Transcripts/`, named after the Meeting note with ` (transcript)`.

## Information kept

- **Name** — `<note name> (transcript)`, set when it is first written.
- **Paragraphs** — Time, who speaks (Me, Speaker N, Name (Speaker N) or Others) and text, Vocabulary variants already replaced.
- **Stars** — ⭐ at the start of each paragraph a Mark falls in.
- **Language** — The Meeting's language.
- **Meeting link** — The link back to the Meeting note.
