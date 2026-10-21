---
appliesTo:
- type: entity
  id: template
  effect: removes
permits:
- actors:
  - user
  when:
  - fact: Name
    is-not: Notes
references:
- kind: code
  role: implementation
  target: Takku/Settings/TemplatesSection.swift#TemplatesSection
- kind: code
  role: implementation
  target: Takku/Settings/TakkuFolder.swift#TakkuFolder.ensureDefaultTemplate
- kind: code
  role: implementation
  target: Takku/Settings/TakkuFolder.swift#TakkuFolder.template
---

# The User deletes any Template except Notes

Notes has no *Delete*. When the Templates folder is empty, or the Default Template is gone, Takku creates Notes again at launch and makes it the default; a Meeting whose Template is gone uses Notes as the User edited it.
