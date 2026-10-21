---
kind: alternate
routes:
  mac: Mac
steps:
- text: Choose Start meeting
  kind: actor
  actor: user
  entities:
  - entity: meeting
    effect: reads
    facts: []
  contexts:
    mac:
      place: takku::menu
- text: Start recording a new Meeting
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: creates
    to: Recording
    facts:
    - Takku ID
    - Started
    - Template
    - Summary Profile
    - Transcription model
    - Meeting languages
  - entity: recording
    effect: creates
    to: Capturing
    facts:
    - Tracks
    with: meeting
  contexts:
    mac:
      place: takku::menu
- text: 'Use the calendar is on and an event is in progress: not all-day, not cancelled or declined, starting at most 10 minutes from now'
  kind: condition
  entities:
  - entity: settings
    effect: reads
    facts:
    - Use the calendar
  contexts:
    mac:
      place: takku::menu
- text: Pick the event with invited people whose start is closest, and remember the other candidates for the menu
  kind: product
  actor: user
  entities:
  - entity: meeting
    effect: changes
    facts:
    - Calendar event
  contexts:
    mac:
      place: takku::menu
- text: Create the Meeting note named after the event, with its invited people, other than the User, rooms, resources and groups, as Participants
  kind: product
  actor: user
  entities:
  - entity: meeting-note
    effect: creates
    facts:
    - Name
    - Date
    - Tags
    - Participants
    - Managed section
  contexts:
    mac:
      place: takku::menu
references:
- kind: code
  role: implementation
  target: Takku/Calendar/MeetingCalendar.swift#MeetingCalendar.eventsInProgress
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/CalendarEvent.swift#CalendarEvent.candidates
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/CalendarEvent.swift#CalendarEvent.participantName
---

# Name the note after the calendar event in progress

## Trigger

The User starts a Meeting while a calendar event is in progress.

## Outcome

The note is `<date> <time> - <event title>` with the invited people listed, and the menu offers *Calendar event* to pick another one.

## Edge cases

- Reading the calendars happens after the recording has started, so it never delays it.
- Names are made readable: `ROSSI, MARIO` and `mario.rossi@…` both become Mario Rossi.
