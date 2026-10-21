---
appliesTo:
- type: capability
  id: process-meeting
- type: capability
  id: resume-processing
- type: capability
  id: retry-meeting
references:
- kind: code
  role: implementation
  target: Takku/Processing/MeetingProcessor.swift#MeetingProcessor.enqueue
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Meetings are processed one at a time, in arrival order

A stopped Meeting, a resumed one and a Retry wait their turn in one queue; another Meeting can be recorded meanwhile.
