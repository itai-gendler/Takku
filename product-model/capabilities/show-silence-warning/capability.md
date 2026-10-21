---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.silenceWarnings
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.notifySilentTracks
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/TrackSilence.swift#TrackSilence
---

# Show silence warning

While recording, Takku notices a Track that receives no sound, so a Meeting is not lost unnoticed.
