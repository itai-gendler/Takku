---
kind: alternate
routes:
  mac: Mac
steps:
- text: Turn off Keep a Summary log
  kind: actor
  actor: user
  entities:
  - entity: settings
    effect: reads
    facts:
    - Keep a Summary log
  contexts:
    mac:
      place: takku::recordings
- text: Stop copying Summary requests and replies to the log
  kind: product
  actor: user
  entities:
  - entity: settings
    effect: changes
    facts:
    - Keep a Summary log
  contexts:
    mac:
      place: takku::recordings
---

# Stop keeping the Summary log

## Trigger

The User does not want copies of Meetings' text outside the Vault.

## Outcome

Later Summaries add no entry; the entries already there stay until deleted.
