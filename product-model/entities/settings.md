---
singleton: true
references:
- kind: code
  role: implementation
  target: Takku/Settings/AppSettings.swift#AppSettings
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Settings

Takku's settings on this Mac, kept once whatever the Vault.

## Information kept

- **Vault folder** — The Obsidian vault Takku writes into; none until chosen.
- **Editor** — The app Meeting notes and Transcripts open in: Obsidian unless another is chosen, the Mac's default Markdown app without Obsidian.
- **Default Template** — The Template every Meeting starts with; Notes until another is chosen.
- **Summary Profile** — The Profile new Meetings use, or Transcript for none; none until chosen.
- **Meeting languages** — The languages Meetings can be in: Italian and English until changed.
- **Keep audio for** — Days the audio of a concluded Meeting is kept: 7 unless changed, 1 to 90.
- **Keep a Summary log** — On unless turned off.
- **Open at login** — Whether Takku is a login item.
- **Use the calendar** — Off unless turned on and macOS allows the calendars.
- **Suggest recording** — Suggest recording when a call starts: off unless turned on.
- **Check for updates** — On unless turned off.
