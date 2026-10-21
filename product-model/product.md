---
id: takku
summary: A macOS menu bar app that records meetings, transcribes them on the Mac and writes the Transcript and a Summary into an Obsidian vault.
category: productivity
tags:
- meetings
- transcription
- obsidian
- macos
authors:
- name: mameli
  url: https://github.com/mameli
license: MIT
languages:
- en
- it
limitations:
- Meeting audio is transcribed only on this Mac; a Meeting goes only to the Summary Provider the user chose for it, or to none.
- 'Takku records calls: the microphone and the system audio together, in one language per Meeting.'
- Takku never starts or stops a Meeting by itself; it only suggests it.
- 'Takku has no integrations of its own: other services are reached through the user''s Hook.'
- 'Takku has no editor of its own: Meeting notes, Templates and the Vocabulary are plain Markdown edited in other apps.'
references:
- kind: doc
  role: intent
  target: README.md
- kind: spec
  role: intent
  target: docs/SPEC.md
- kind: doc
  role: context
  target: CONTEXT.md
- kind: adr
  role: intent
  target: docs/adr/0001-eu-by-preference.md
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#TakkuApp
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController
- kind: code
  role: implementation
  target: Takku/Localizable.xcstrings
---

# Takku

Takku is a macOS menu bar app for calls. It records the microphone and the system audio of a Meeting, opens a Meeting note in the user's Obsidian vault for Personal notes, and after the stop writes the Transcript, with Speakers told apart, and a Summary shaped by a Template. The Transcript is made on the Mac; the Summary is written by a local model or an OpenAI-compatible Provider the user picks in a Summary Profile, or skipped. The project's own specification, `docs/SPEC.md`, and glossary, `CONTEXT.md`, describe how each part works; this model uses their terms and links them.

## Intent

"A macOS menu bar app that records your meetings, transcribes them **on your Mac** and writes the Transcript and a Summary into your **Obsidian** vault. You choose who writes the Summary: a model running locally, or any OpenAI-compatible provider you trust (for example one hosted in the EU)." (README)

Data stays local or in the EU by preference; where a Meeting goes is the user's choice (`docs/adr/0001-eu-by-preference.md`).
