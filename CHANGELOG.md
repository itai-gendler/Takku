# Changelog

What changes in each version of Takku, starting from 1.2.0. Downloads and earlier versions: [GitHub Releases](https://github.com/mameli/Takku/releases).

## Unreleased

### Removed: Steno support

Takku was called Steno until 0.2.1 (October 2026). Until 1.2.0 it brought over what Steno had left on the Mac and read the notes Steno wrote; from this version it does neither. If you never used Steno, nothing changes for you.

**What no longer works**

- **Settings, Recordings, models and API keys of Steno are not moved to Takku any more.** If Steno is still installed, open Takku 1.2.0 once before updating: it moves everything. Otherwise set Takku up again: choose the vault, add your Summary Profiles with their API keys, and download the transcription model. Steno's data folder, `~/Library/Application Support/Steno`, can then be deleted.
- **Notes written by Steno are not recognised.** A note or Transcript with `steno_id` in its frontmatter, or a summary between `%% steno:start %%` and `%% steno:end %%`, is no longer a Takku meeting: *Retry* cannot find it, it is missing from *Recent meetings → Show all in Obsidian…*, and a Hook is never run on it. Notes that Takku has rewritten at least once (after a Retry) already use `takku_id` and are fine.

**Converting old notes**

Run this in your vault folder. It changes only the `steno_id:` lines and the two markers, in the files that have them; back up the vault first, or commit it if it is a git repository.

```sh
grep -rl --null --include='*.md' -e '^steno_id:' -e '^%% steno:' . | xargs -0 sed -i '' -e 's/^steno_id:/takku_id:/' -e 's/^%% steno:start %%$/%% takku:start %%/' -e 's/^%% steno:end %%$/%% takku:end %%/'
```

The meetings are then recognised again as they were.

## 1.2.0

- **Hook**: an executable at `~/.takku/hooks/after-processing` runs when each meeting is ready, and again after every successful Retry, with the paths of the meeting note and of the Transcript. Send meetings to Notion, Confluence, git or anywhere else. Guide and a ready-made Notion hook: [takku.app/hooks](https://takku.app/hooks).
