---
scope: The Takku menu bar app and its TakkuCore domain package at the pinned source revision.
method: Static reading of the app, the core package, the specification, the glossary and the ADRs.
covered:
- description: Menu, Meeting start and stop, Marks, calendar choice and the welcome window.
  paths:
  - Takku/MeetingController.swift
  - Takku/TakkuApp.swift
  - Takku/WelcomeView.swift
  - Takku/Calendar/
- description: Audio capture, permissions, call watching and silence tracking.
  paths:
  - Takku/Capture/
- description: Processing queue, Retry, retention, Summary log storage, Hook runner, notifications, update check and global shortcuts.
  paths:
  - Takku/Processing/
- description: Settings window sections, Profiles, Keychain and the ~/.takku folder.
  paths:
  - Takku/Settings/
- description: Vault writing, Editor choice and following renamed notes.
  paths:
  - Takku/Vault/
- description: Transcription models, local transcription orchestration and diarization.
  paths:
  - Takku/Transcription/
- description: Problem report.
  paths:
  - Takku/ProblemReporter.swift
- description: 'Domain logic: Meeting note, naming, Processing states, retention, Profiles, chat client, Summary prompt and chunking, Templates, Vocabulary, Hook, call watch, calendar events, Summary log, Transcript and Speakers.'
  paths:
  - TakkuCore/Sources/TakkuCore/
- description: Shipped user interface strings and their Italian translation.
  paths:
  - Takku/Localizable.xcstrings
  - Takku/InfoPlist.xcstrings
exclusions:
- description: Build, signing, entitlements and Xcode project configuration.
  paths:
  - Takku.xcodeproj/
  - Config/
- description: Release, CI and repository automation.
  paths:
  - scripts/
  - .github/
- description: Unit tests of the core package.
  paths:
  - TakkuCore/Tests/
  - TakkuCore/Package.swift
- description: Icons and image assets.
  paths:
  - Takku/Assets.xcassets/
  - docs/assets/
- description: Example Hook scripts shipped for users to copy.
  paths:
  - examples/
unmapped:
- description: 'Speech filtering and language-detection code: speech ranges, stock-sentence and other-language filters, echo and residue removal, sentence joining.'
  paths:
  - TakkuCore/Sources/TakkuCore/SpeechRanges.swift
  - TakkuCore/Sources/TakkuCore/Hallucination.swift
  - TakkuCore/Sources/TakkuCore/OtherLanguage.swift
  - TakkuCore/Sources/TakkuCore/Echo.swift
  - TakkuCore/Sources/TakkuCore/TimedText.swift
  - Takku/Transcription/LocalTranscriber.swift
- description: Segment writing, device-change restarts and gap filling inside the capture code.
  paths:
  - Takku/Capture/SegmentedTrackWriter.swift
  - Takku/Capture/MicrophoneCapture.swift
  - Takku/Capture/SystemAudioCapture.swift
  - TakkuCore/Sources/TakkuCore/TrackSegmenter.swift
limitations: []
---

# Coverage
