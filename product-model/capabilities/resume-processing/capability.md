---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.resumeAfterLaunch
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProcessingRecord.swift#ProcessingRecord.afterRestart
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.recoverRecording
---

# Resume processing

At launch Takku picks up what a quit or a crash interrupted, oldest Meeting first.
