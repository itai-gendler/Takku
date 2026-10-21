---
domain: transcription
references:
- kind: code
  role: implementation
  target: Takku/Transcription/TranscriptionModels.swift#TranscriptionModels
- kind: code
  role: implementation
  target: Takku/Transcription/TranscriptionModels.swift#TranscriptionModel
---

# Transcription model

One of the speech recognition models Takku offers (Whisper Large v3 Turbo, its full version, Small, Parakeet v3, Parakeet Ultra), downloaded once to this Mac.

## Information kept

- **Name** — As Settings shows it, with a short note on what it is good at.
- **Download size** — From about 220 MB to 1.6 GB.
- **Download progress** — Whole percent while downloading, then *Preparing…* while macOS prepares it.
- **In use** — Whether it is the model new Meetings and Retry use; Large v3 Turbo until another is chosen.

## States

### Not downloaded

Offered for download.

### Downloading

Being downloaded and prepared.

### Downloaded

On this Mac, ready to use.
