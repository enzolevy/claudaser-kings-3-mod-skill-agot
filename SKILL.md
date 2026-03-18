---
name: ck3-modding
description: >
  CK3 modding skill for Crusader Kings 3. Use when creating, editing, or debugging
  CK3 mods, writing Paradox Script, working with events, decisions, traits, CBs,
  GUI, localization, or any CK3 game files. Also use when the user mentions
  Crusader Kings, CK3, Paradox Script, mod development for CK3, or asks about
  triggers, effects, scopes, on_actions, or scripted_effects in a CK3 context.
  Activate even for seemingly simple CK3 scripting questions — Paradox Script
  has many non-obvious pitfalls that require consulting reference documentation.
---

# CK3 Modding Skill

Paradox Script is a proprietary DSL used by Crusader Kings 3. It is poorly documented
and full of non-obvious pitfalls. This skill provides reference documentation,
actionable recipes, and utility scripts for CK3 modding.

## Golden Rule

Never invent triggers, effects, scopes, or Paradox Script syntax.
Always verify against: vanilla game files > references/wiki/ > script_docs.
Do NOT use web search unless the user explicitly requests it.

## Configuration

This skill expects the following paths. Ask the user to provide them if not set:
- CK3_GAME_PATH: path to the CK3 game/ folder
- CK3_USER_PATH: path to Documents/Paradox Interactive/Crusader Kings III/
- CK3_MOD_PATH: path to the current mod being worked on

First-time setup instructions: read references/setup.md

## Updating the Wiki

The references/wiki/ folder contains a snapshot of the CK3 modding wiki.
To update: cd references/wiki/ && git pull origin master
Recommended before a major modding session.

## Quick Navigation

### I need language reference documentation
- Language syntax → references/wiki/wiki_pages/Scripting.md
- Triggers → references/wiki/wiki_pages/Triggers.md
- Full triggers list → references/wiki/wiki_pages/Triggers_list.md
- Effects → references/wiki/wiki_pages/Effects.md
- Full effects list → references/wiki/wiki_pages/Effects_list.md
- Scopes and event targets → references/wiki/wiki_pages/Scopes.md
- Full scopes list → references/wiki/wiki_pages/Scopes_list.md
- Modifiers → references/wiki/wiki_pages/Modifier_list.md
- Variables → references/wiki/wiki_pages/Variables.md
- Data types (loc) → references/wiki/wiki_pages/Data_types.md
- Lists / arrays → references/wiki/wiki_pages/Lists.md
- Weight modifiers → references/wiki/wiki_pages/Weight_modifier.md
- Scripted effects → references/wiki/wiki_pages/Scripted_effects.md
- Console commands → references/wiki/wiki_pages/Console_commands.md

### I want to create / modify something
- Create an event → references/patterns/events.md
- Create a decision → references/patterns/decisions.md
- Create a trait → references/patterns/traits.md
- Create a character interaction → references/patterns/characters.md
- Create a casus belli → references/patterns/casus-belli.md
- Modify culture/religion → references/patterns/culture-religion.md
- Modify the GUI → references/patterns/gui.md
- Add graphical assets → references/patterns/gfx.md
- Add localization → references/patterns/localization.md
- Set up a new mod → references/patterns/mod-setup.md

### I want to understand game structure
- Vanilla folder tree → references/structure/vanilla-tree.md
- Load order and overrides → references/structure/load-order.md
- Debug an error → references/structure/common-errors.md

### Useful Commands
```
# Search for a trigger/effect in vanilla game files
grep -rn "<term>" $CK3_GAME_PATH/ --include="*.txt" | head -20

# Search in the embedded wiki
grep -rn "<term>" references/wiki/wiki_pages/ | head -20

# Search with context (3 lines before/after)
./scripts/find_examples.sh $CK3_GAME_PATH "<term>"

# Index all vanilla files
./scripts/index_vanilla.sh $CK3_GAME_PATH
```
