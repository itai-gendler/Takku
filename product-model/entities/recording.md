---
domain: recordings
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Recording.swift#Recording
- kind: code
  role: implementation
  target: Takku/Processing/RecordingStorage.swift#RecordingStorage
- kind: doc
  role: context
  target: CONTEXT.md
---

# Recording

The audio of a Meeting, in two Tracks, kept on this Mac outside the Vault for a limited time, with what was recognised in it.

## Information kept

- **Tracks** — Me (the microphone) and Others (the system audio), each saved in 5-minute Segments that share the Meeting's start clock.
- **Segment results** — The language and the text recognised in each Segment and the model that recognised it, so a new Processing does not transcribe it again.
- **Speaker turns** — The voices told apart in the Others Track.
- **Transcript copy** — A copy of the Transcript without frontmatter next to the audio.
- **Audio size** — The space the audio takes, about 20 MB per hour of Meeting; Settings shows the total.

## States

### Capturing

The Meeting is being recorded into it.

### Kept

Closed, with its audio on this Mac.

### Audio deleted

The audio and everything recognised from it are gone; the Meeting and its state remain.
