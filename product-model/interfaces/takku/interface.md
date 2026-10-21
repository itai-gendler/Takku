---
type: desktop-app
actors:
- user
references:
- kind: code
  role: implementation
  target: Takku/TakkuApp.swift#MeetingMenu
- kind: code
  role: implementation
  target: Takku/Settings/SettingsView.swift#SettingsView
- kind: code
  role: implementation
  target: Takku/Processing/GlobalHotKey.swift#GlobalHotKey
- kind: code
  role: implementation
  target: Takku/Processing/Notifications.swift#Notifications
- kind: spec
  role: intent
  target: docs/SPEC.md
---

# Takku for Mac

The menu bar app on the user's Mac: the menu, the global shortcuts ⌃⌥⌘R and ⌃⌥⌘M, the Settings window, the welcome window and Takku's notifications. Nobody signs in; the person at the Mac uses all of it. The Vault, the Editor, the Summary Provider, the calendars and the Hook are reached from here as outbound dependencies.
