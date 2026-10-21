---
availability:
- place: takku
references:
- kind: code
  role: implementation
  target: Takku/ProblemReporter.swift#ProblemReporter.report
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProblemReport.swift#ProblemReport
---

# Report a problem

*Report a problem…* writes a report with Takku's version, the Mac, the transcription model, the Summary model and Takku's logs of the last 3 days, and opens a GitHub bug report with those fields filled in. Nothing is sent by itself.
