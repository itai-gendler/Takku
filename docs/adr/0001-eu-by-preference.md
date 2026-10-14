# Meeting data stays in the EU by preference; where it goes is the user's choice

Takku exists because a company policy forbids processing meeting audio and text outside the EU, which rules out Granola. Keeping a Meeting local or in the EU is therefore the case Takku is designed and documented for: transcription is always on the Mac, the examples and advice point to local or EU-hosted Providers, and non-European hyperscalers fit as long as processing happens in an EU region. It is a preference, not a rule Takku enforces: other users have other policies, and Takku cannot check where a Provider processes data anyway. The user can choose a Provider outside the EU, and the responsibility for that choice is theirs.

What Takku does enforce is that a Meeting only goes where the user chose to send it:

- Takku ships no default Provider: the user always picks one, or none (*Transcript*).
- There is no automatic fallback to another Provider when the chosen one fails: Processing stops and the user decides whether to retry or regenerate with another Profile. A fallback could send data to a Provider not chosen for that Meeting.
- The Profile is fixed when the Meeting starts, so a Meeting never goes to a Provider chosen for another one.

## History

- **4 October 2026**: a development exception allowed a Profile outside the EU (OpenRouter) for test recordings only.
- **14 October 2026**: the strict rule ("every Provider must be local or in the EU") became a preference, and the development exception was dropped as no longer needed. Takku had never blocked a Provider outside the EU; the rule now says what the app already did. The same principle covers the Hook ([ADR 0007](0007-hook-after-processing.md)).
