---
appliesTo:
- type: capability
  id: report-problem
- type: entity
  id: summary-log-entry
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/ProblemReport.swift#ProblemReport.summary
- kind: adr
  role: intent
  target: docs/adr/0010-summary-log.md
---

# A problem report names only the Summary model, and never includes the Summary log

The report and the bug form say the model and whether it runs on this Mac or is remote, never the Profile's name or address, since they can name a company. Nothing is sent by Takku: the User checks the file before attaching it.
