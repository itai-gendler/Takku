---
kind: validation
routes:
  mac: Mac
steps:
- text: Choose Test connection on a Profile whose base URL starts with http:// and is not this Mac
  kind: actor
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Base URL
  contexts:
    mac:
      place: takku::summary-profiles
- text: Send nothing and say to use https://, http:// being allowed only for servers on this Mac
  kind: product
  actor: user
  entities:
  - entity: summary-profile
    effect: reads
    facts:
    - Base URL
  contexts:
    mac:
      place: takku::summary-profiles
---

# Refuse a plain-text address to another machine

## Trigger

The base URL is plain http to another machine, even on the local network.

## Outcome

Nothing is sent; the same refusal applies to Summaries.
