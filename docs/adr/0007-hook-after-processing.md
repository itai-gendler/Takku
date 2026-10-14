# Other services are reached through one Hook, not through integrations

Sending a Meeting somewhere else after Processing (Confluence, Notion, a git commit of the Vault) is useful, but every integration built into Takku would mean code, credentials and API changes to maintain for a service that is not Takku's job. Takku instead runs one executable written by the user, the **Hook**, at `~/.takku/hooks/after-processing`, found by convention like the Templates and the Vocabulary: no setting turns it on, its presence does. It runs after every Processing that completes, including a successful Retry, with two arguments: the absolute paths of the Meeting note and of the Transcript. The files are the payload: the note's frontmatter already has the title, the date, the `participants` and the `takku_id` the script uses to update what it created before.

## Considered options

- **Built-in integrations** (Notion, Confluence…): one per service, each with its own credentials and API. Rejected: Takku does one thing.
- **A JSON payload on stdin** (as Muesli does): a second format to keep stable, with nothing the files do not already say.
- **A folder of hooks run in order**: more than one destination is the script's business.
- **Running it only by hand from the menu**: the note can still change after Processing (Speaker names, Personal notes), but a Retry runs the Hook again and the script updates by `takku_id`, so automatic is enough.

## Consequences

- The Hook can send a Meeting outside the EU. As for Providers ([ADR 0001](0001-eu-by-preference.md)), that is the user's choice and Takku does not check it.
- macOS treats Takku as the responsible process of the Hook, so the script can use Takku's permissions (microphone, system audio, calendars). Anyone able to write in `~/.takku/hooks/` can therefore use them. Accepted, as with git hooks: writing there already needs code running as the user, and detaching the child process would need a private API.
- The arguments are a contract: changing them breaks the users' scripts.
- A failing Hook never fails the Meeting. Rerunning it is done by hand from the Terminal (the log has the command), because a Retry also regenerates the Summary.
