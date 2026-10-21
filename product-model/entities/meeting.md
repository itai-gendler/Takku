---
relations:
- entity: recording
  verb: is captured in
  cardinality: one-to-one
- entity: meeting-note
  verb: is written in
  cardinality: one-to-one
- entity: transcript
  verb: is transcribed in
  cardinality: one-to-one
- entity: summary-log-entry
  verb: is logged in
  cardinality: one-to-many
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProcessingRecord.swift#ProcessingRecord
- kind: doc
  role: context
  target: CONTEXT.md
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Meeting

A call recorded with Takku, from start to stop, and its Processing afterwards. Everything else revolves around it; its Recording folder keeps its state so Processing resumes after a restart.

## Information kept

- **Takku ID** — The identifier the Meeting note, the Transcript and the Recording share (`takku_id`).
- **Started** — When recording began; the menu shows the time elapsed since.
- **Ended** — When it was stopped, or the last audio write of a Recording rebuilt after a crash.
- **Template** — The Template the Summary follows: the one chosen in the menu at the start, changeable until the stop and on Retry.
- **Summary Profile** — The Summary Profile in use when the Meeting started, or Transcript for none; only Retry replaces it.
- **Transcription model** — The model the Meeting is transcribed with during the call: the one in use at the start; a Retry, or Processing resumed after a restart, uses the one in use then.
- **Meeting languages** — The languages ticked at the start, which the Meeting's language is detected among during the call; like the model, a Retry uses those ticked then.
- **Marks** — The moments the user marked as important, in seconds from the start.
- **Calendar event** — While recording, the calendar event the Meeting note is named after, or none.
- **Failure reason** — Why the last Processing failed, also shown in the menu.

## States

### Recording

Both Tracks are being recorded.

### Queued

Stopped, or sent back by Retry, and waiting for its turn in the Processing queue.

### Processing

Takku is completing the Transcript and writing the Summary.

### Regenerating

Retry is writing a new Summary from the Transcript in the Vault, the audio being deleted.

### Completed

Processing ended without problems; warnings are allowed.

### Failed

Processing ended with a problem; the reason is kept and Retry is offered.
