---
kind: primary
routes:
  mac: Mac
steps:
- text: Choose Mark this moment, or press ⌃⌥⌘M
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Save the moment with the Meeting at once
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    facts:
    - Marks
  contexts:
    mac:
      place: takku::menu
- text: 'Turn the red dot into a star for a second and show Marked moments: N in the menu'
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts:
    - Marks
  contexts:
    mac:
      place: takku::menu
---

# Mark a moment while recording

## Trigger

The User hears something that matters during the call.

## Outcome

The mark is saved and survives a crash; at Processing the paragraph it falls in, the last one starting at or before it, starts with ⭐.

## Edge cases

- Takku plays no sound: it would be recorded in the Others Track.
- Several marks in one paragraph give one star; a mark before anyone spoke stars nothing.
- If another app already uses ⌃⌥⌘M, the menu says so and *Mark this moment* still works.
