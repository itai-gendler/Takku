---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Delete log and confirm Delete the Summary log?
  kind: actor
  actor: user
  entities:
  - entity: summary-log-entry
    effect: reads
    facts:
    - Size
  contexts:
    mac:
      place: takku::recordings
- text: Delete every Summary log entry
  kind: product
  actor: user
  entities:
  - entity: summary-log-entry
    effect: removes
  contexts:
    mac:
      place: takku::recordings
---

# Delete the Summary log

## Trigger

The User wants the copies of Summary requests gone.

## Outcome

The log is empty; Meeting notes and Transcripts in the Vault are not touched.
