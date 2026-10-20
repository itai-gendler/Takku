# The Summary log keeps every request and reply of a Summary, on this Mac, for the user to improve the Templates

Improving a Template takes real examples: what Takku sent the model and what came back, on many Meetings. The Vault does not keep them. The Transcript is there, but the request around it (rules, Template, Vocabulary, Personal notes, participants) is not, and the Summary in the note is what the user edited afterwards, not what the model wrote. Takku therefore copies every request of a Summary and every reply, as they went, into the **Summary log**: one JSON file per Summary in `~/.takku/summary-log/`. The user gives some of them to a large model and asks what to change in the Template. Takku writes the log and never reads it back.

An entry has two parts. `about` opens with an empty `comment`, for the user to write by hand in the file what was wrong with that Summary; Takku has no field for it. Then it holds the Meeting (`takku_id`, the note's name after the rename, when it started), the Template, the Profile's name, the model, `on this Mac` or `remote`, and the error if the Summary failed. `calls` holds every request in order, by kind: `single`, or `partial`, `group` and `merge` for a Summary in blocks, then `title`. Each call has the request body and the reply body as they went, the HTTP status and the seconds. The bodies are kept whole: `finish_reason`, the reasoning and the tokens used are what explain a bad Summary, and the provider's error is not cut at 300 characters as it is in the note. The file is named `2026-10-20 1823 - Notes - claude-haiku-5.5.json`, from when the Summary was written. Every Retry gives a new entry, because comparing runs on the same Meeting is how a change is judged ([ADR 0008](0008-summary-reads-the-transcript-as-markdown.md)).

## Considered options

- **Only the final Summary and its inputs**: loses the requests of a Summary in blocks, where a long Meeting loses most, and the reply as the model wrote it.
- **One JSONL file**: a cap in bytes means rewriting it at every Summary, and a model cannot be given only the Meetings worth looking at.
- **Markdown**: the line between Takku's rules and the Transcript would blur; JSON keeps the messages exactly as sent.
- **In the Vault**: it is synced (Obsidian Sync, iCloud) and the entries are working material, not notes.
- **In `~/Library/Application Support/Takku/`**: next to the Recordings, but far from the Templates the log is meant to improve.
- **A cap of 1 MB**: ten to fifteen Meetings of an hour (50–110 KB each), too few to see how a Template behaves. 5 MB is fifty to seventy.
- **A cap by number of entries**: a short call and a long one would count the same.
- **Always on, with no setting**: Takku is used by others, who need to know this copy exists and to be able to stop it.

## Consequences

- The text of work Meetings is in clear outside the Vault, in a folder no one syncs. The Transcript was already in clear in the Vault and, for the days the audio is kept, in the Recording folder. The setting is on by default and next to the audio in *Settings → Recordings*, with its size and *Delete log*. Turning it off stops writing and leaves the entries until the user deletes them.
- The log never holds the provider's address or the API key: the address is not in the request body and the key is in a header. *Report a problem…* never includes the log, because the report goes to GitHub.
- The log has its own limit. Neither the audio's retention nor *Delete audio* touches it, and deleting a note does not delete its entries. Past 5 MB the oldest entries are deleted after each new one; the newest is always kept, even if it alone is larger.
- Only the requests of a Summary are logged, not *Test* in the Profiles. A Summary that never reached the model (deleted Profile, no speech) leaves no entry. An entry is written once the Summary ends: if Takku quits halfway, that Summary leaves none.
