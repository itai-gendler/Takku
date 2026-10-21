---
domain: recordings
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/SummaryLog.swift#SummaryLog
- kind: code
  role: implementation
  target: Takku/Processing/SummaryLogStorage.swift#SummaryLogStorage
- kind: adr
  role: intent
  target: docs/adr/0010-summary-log.md
---

# Summary log entry

One JSON file in `~/.takku/summary-log/` with every request Takku sent the model for one Summary and every reply, as they went, for the user to improve their Templates.

## Information kept

- **Comment** — Empty, for the user to write by hand what was wrong with that Summary.
- **Meeting** — The `takku_id`, the note's name after the rename, and when the Meeting started.
- **Template** — The Template the Summary followed.
- **Profile** — The Profile's name and model, and whether it runs on this Mac or is remote; never its address.
- **Error** — Why the Summary failed, if it did.
- **Calls** — Every request in order (single, or partial, group and merge, then title) with the request and reply bodies, the HTTP status and the seconds.
- **Size** — Its size on disk; Settings shows the total.
