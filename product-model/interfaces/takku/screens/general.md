---
entities:
- entity: settings
  shows:
  - Open at login
  - Use the calendar
  - Suggest recording
  - Check for updates
  collects:
  - Open at login
  - Use the calendar
  - Suggest recording
  - Check for updates
references:
- kind: code
  role: implementation
  target: Takku/Settings/GeneralSettings.swift#LaunchAtLoginToggle
- kind: code
  role: implementation
  target: Takku/Settings/GeneralSettings.swift#CalendarToggle
- kind: code
  role: implementation
  target: Takku/Settings/GeneralSettings.swift#SuggestCallsToggle
- kind: code
  role: implementation
  target: Takku/Settings/GeneralSettings.swift#UpdatesToggle
---

# General

Settings that apply to the whole app: Open at login, Use the calendar, Suggest recording when a call starts, and Check for updates, under Takku's name and version.
