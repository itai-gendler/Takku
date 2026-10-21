# Screenshots go into the Vault and never reach the Summary model

Issue #4 asked for screenshots during a Meeting, as Granola takes them, timestamped, in the Meeting note and available to the Summary. Takku takes them (⌃⌥⌘S, which also makes a Mark) and puts them in the Vault, under the Transcript paragraph they fall in and under the point of the Summary that cites that paragraph, but the model never sees them: not the image, not its file name. The placing needs no help from the model: it already cites the Transcript times of every point (94% of the 1,102 bullets in the Summary log on 2026-10-21), and Takku reads them before removing them. A screenshot of a call shows whatever is on screen (a chat on the other monitor, a customer's data in a shared slide), and the Providers Takku prefers are local or in the EU ([ADR 0001](0001-eu-by-preference.md)) and often run models that cannot read images. The Mark the Screenshot makes is what tells the Summary that moment mattered.

## Considered options

- **Sending the images to the model** when the Provider profile says it reads them: a second kind of content in every request, a setting per Profile, and screen contents leaving the Mac for a remote Provider. Rejected.
- **A placeholder in the Transcript the model can cite** ("📷 at 12:30"), copied next to the point it belongs to: the model would choose by meaning rather than by time, but it has to know a Screenshot is there, and small models drop or repeat placeholders. The cited times place them without it.
- **Taking the image from the clipboard** (the user presses ⌘⌃⇧4 first): no Screen Recording permission, but two keystrokes, and an old image left in the clipboard ends up in the Meeting.

## Consequences

- Takku needs the Screen Recording permission, asked as the last, optional step of the welcome window (macOS applies it only when Takku is reopened, which costs nothing during setup) and otherwise the first time ⌃⌥⌘S is pressed. Without it the Mark is still made.
- The `![[…]]` lines in the Transcript are skipped when it is read back, so a Regeneration does not send them to the model either.
- A Template cannot ask the model to describe or use the Screenshots.
- A point that cites no time, or a paragraph no point cites, leaves its Screenshot in a `### Screenshots` list after the Summary. When several points cite the same paragraph, the Screenshot goes under the first one.
