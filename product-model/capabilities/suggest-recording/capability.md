---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/Capture/CallDetector.swift#CallDetector
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/CallWatch.swift#CallWatch
---

# Suggest recording

With *Suggest recording when a call starts* on, Takku looks every 3 seconds at which apps use an audio input, recording nothing, and suggests starting when a call seems to start and stopping when it seems over.
