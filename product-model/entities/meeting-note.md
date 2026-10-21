---
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/MeetingNote.swift#MeetingNote
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/VaultNaming.swift#VaultNaming
- kind: code
  role: implementation
  target: Takku/Vault/Vault.swift#Vault
- kind: spec
  role: intent
  target: docs/SPEC.md
- kind: doc
  role: context
  target: CONTEXT.md
---

# Meeting note

The Markdown file in the Vault's `Meetings/` folder holding the Summary, the Personal notes and the link to the Transcript. Takku creates it at the start and opens it in the Editor; the user writes in it during and after the call.

## Information kept

- **Name** — `<date> <time> - <title>`: the provisional *Meeting*, the calendar event's title, or the title generated with the Summary; ` (2)` is added when the name is taken.
- **Date** — When the Meeting started; written at creation, the user's afterwards.
- **Tags** — `meeting`; written at creation, the user's afterwards.
- **Participants** — Who the calendar event invited, by name; written at creation and corrected by the user.
- **Speaker names** — The `speakers` list the user writes: `Speaker N = Name`.
- **Personal notes** — Everything the user writes outside the Managed section.
- **Managed section** — The part between `%% takku:start %%` and `%% takku:end %%`: the recording notice, then the Summary or a ⚠️ reason, and the Transcript link.
- **Duration** — How long the Meeting lasted (`duration`).
- **Language** — The Meeting's detected language (`language`).
- **Template** — The name of the Template the Summary followed (`template`).
- **Summary provider** — The name of the Summary Profile that wrote it (`summary_provider`).
- **Transcript link** — The link to the Transcript (`transcript`).
