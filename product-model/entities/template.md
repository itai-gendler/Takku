---
domain: templates
references:
- kind: code
  role: implementation
  target: TakkuCore/Sources/TakkuCore/Template.swift#Template
- kind: code
  role: implementation
  target: Takku/Settings/TakkuFolder.swift#TakkuFolder
- kind: doc
  role: context
  target: CONTEXT.md
---

# Template

A Markdown file in `~/.takku/templates/` whose text tells the model what to write in the Summary and how, the same whatever the Vault.

## Information kept

- **Name** — The file name, shown in the menus; the `name` in its frontmatter is what the Meeting note records.
- **Summary language** — `summary_language` in its frontmatter: the language every Summary with it is written in, or `auto` for the Meeting's.
- **Instructions** — The body: the structure and instructions passed to the model as written.
