---
appliesTo:
- type: capability
  id: retry-meeting
- type: capability
  id: browse-recent-meetings
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProcessingRecord.swift#ProcessingRecord.Status
---

# Retry is offered only for a concluded Meeting

A Meeting recording, queued, processing or regenerating offers only *Open note*; a completed or failed one also offers *Retry*.
