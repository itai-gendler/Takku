---
availability:
- place: takku
domain: recordings
references:
- kind: code
  role: implementation
  target: Takku/Processing/RecordingStorage.swift#RecordingStorage.deleteAudio
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Retention.swift#Retention.expired
- kind: code
  role: implementation
  target: Takku/MeetingController.swift#MeetingController.startDailyCleanUp
---

# Delete expired audio

At launch and then once a day, Takku deletes the audio of concluded Meetings older than *Keep audio for*.
