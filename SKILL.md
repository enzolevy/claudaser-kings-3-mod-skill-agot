---
name: claudaser-kings-3-agot
description: >
  CK3 modding skill for Crusader Kings 3. Use when creating, editing, or debugging
  CK3 mods, writing Paradox Script, working with events, decisions, traits, CBs,
  GUI, localization, buildings, or any CK3 game files. Also use when the user mentions
  Crusader Kings, CK3, Paradox Script, mod development for CK3, or asks about
  triggers, effects, scopes, on_actions, or scripted_effects in a CK3 context.
  Also activate for mod compatibility questions between CK3 mods.
  Activate even for seemingly simple CK3 scripting questions — Paradox Script
  has many non-obvious pitfalls that require consulting reference documentation.
---

# CK3 Modding Skill — AGOT Edition

This is an **AGOT (A Game of Thrones) sub-modding** skill. It covers both vanilla CK3
systems and AGOT's total conversion additions.

> **CRITICAL AGOT RULE:** Before using ANY vanilla pattern guide in `references/patterns/`,
> ALWAYS check if a matching `agot-ext-*.md` exists in `references/agot/`. If it does,
> you MUST read BOTH the vanilla guide AND the AGOT extension guide. AGOT heavily modifies
> 16 vanilla systems — using vanilla-only patterns will produce broken or incompatible mods.

Paradox Script is a proprietary DSL used by Crusader Kings 3. It is poorly documented
and full of non-obvious pitfalls. This skill provides reference documentation,
actionable recipes, and utility scripts for CK3 modding.

## Golden Rule

Never invent triggers, effects, scopes, or Paradox Script syntax.
Always consult the relevant .info file in references/info/ before writing code.
Verify against: .info files > script_docs > AGOT source files > vanilla game files > patterns.
Do NOT use web search unless the user explicitly requests it.
**For AGOT sub-mods**: always search AGOT's scripted_effects/ and scripted_triggers/ for
existing API before writing custom logic.

## Source of Truth Hierarchy

```
1. .info files (references/info/)          — Paradox's own syntax documentation (~166 files)
2. script_docs (references/script_docs/)   — Generated trigger/effect/scope/modifier lists
3. AGOT source files (AGOT mod path)       — AGOT's actual implementations
4. Vanilla game files ($CK3_GAME_PATH)     — Real implementations and patterns
5. AGOT guides (references/agot/)          — AGOT-specific patterns and pitfalls
6. Vanilla patterns (references/patterns/) — Base recipes (check AGOT extension first!)
```

The .info files are THE definitive reference for syntax. They document every key,
type, and valid value for each system. Always check the relevant .info file before
writing code for a system.

script_docs are the exhaustive list of all effects, triggers, scopes, and modifiers
that exist in the game. When unsure if a trigger/effect exists, search script_docs.

**AGOT mod path:**
```
C:/Program Files (x86)/Steam/steamapps/workshop/content/1158310/2962333032
```

## Configuration

This skill expects the following paths. Ask the user to provide them if not set:
- CK3_GAME_PATH: path to the CK3 game/ folder
- CK3_USER_PATH: path to Documents/Paradox Interactive/Crusader Kings III/
- CK3_MOD_PATH: path to the current mod being worked on

First-time setup instructions: read references/setup.md

## Quick Navigation

### I need the official syntax for a system
- Check: references/info/common/<system>/_<system>.info
- Full list: references/info/ (synced from game via scripts/sync_info.sh)
- Sync: `./scripts/sync_info.sh`

### I need to look up a trigger, effect, scope, or modifier
- All effects with syntax and scopes → references/script_docs/effects.log
- All triggers with syntax and scopes → references/script_docs/triggers.log
- All event targets (scope transitions) → references/script_docs/event_targets.log
- All valid modifiers → references/script_docs/modifiers.log
- All scope types → references/script_docs/event_scopes.log

### I want to create / modify something
- Create an event → references/patterns/events.md
- Create a decision → references/patterns/decisions.md
- Create a trait → references/patterns/traits.md
- Create a building → references/patterns/buildings.md
- Create a scheme (murder, seduce, etc.) → references/patterns/schemes.md
- Create a court position → references/patterns/court-positions.md
- Create an activity (feast, hunt, etc.) → references/patterns/activities.md
- Create a character interaction → references/patterns/characters.md
- Create a casus belli → references/patterns/casus-belli.md
- Create men-at-arms types → references/patterns/men-at-arms.md
- Create dynasty legacies/perks → references/patterns/dynasties.md
- Create a government type → references/patterns/governments.md
- Create a lifestyle/perks → references/patterns/lifestyles.md
- Create a story cycle → references/patterns/story-cycles.md
- Create a faction type → references/patterns/factions.md
- Create an epidemic/disease → references/patterns/epidemics.md
- Create a great project (wonder) → references/patterns/great-projects.md
- Create holding types → references/patterns/holdings.md
- Set up historical characters/titles/provinces → references/patterns/history.md
- Modify culture/religion → references/patterns/culture-religion.md
- Modify the GUI → references/patterns/gui.md
- Add graphical assets (textures, models, portraits) → references/patterns/gfx.md
- Modify the map (provinces, terrain, heightmap) → references/patterns/map-modding.md
- Place 3D objects on the map (buildings, locators) → references/patterns/map-objects.md
- Add localization → references/patterns/localization.md
- Set up a new mod → references/patterns/mod-setup.md
- Understand AI behavior/weighting → references/patterns/ai.md
- Understand flags (character, government, trait, building) → references/patterns/flags.md

### I want to mod an AGOT system
- **First-time AGOT setup** → references/agot/agot-setup.md
- **AGOT Submod Core** (portrait/accessory compat) → references/agot/agot-submod-core.md
- **Full AGOT guide index** → references/agot/agot-index.md

#### AGOT-Unique Systems
- Dragons (bonding & taming) → references/agot/agot-dragons-bonding.md
- Dragons (combat & warfare) → references/agot/agot-dragons-combat.md
- Dragons (eggs, genetics, dragonpit) → references/agot/agot-dragons-lifecycle.md
- Dragons (tree, story cycles, dreams) → references/agot/agot-dragons-tree.md
- Valyrian steel swords → references/agot/agot-valyrian-steel.md
- Knighthood & squirehood → references/agot/agot-knighthood.md
- Banking & Iron Bank → references/agot/agot-banking.md
- Colonization & ruin rebuilding → references/agot/agot-colonization.md
- Night's Watch → references/agot/agot-nights-watch.md
- Kingsguard → references/agot/agot-kingsguard.md
- Maesters & Citadel → references/agot/agot-maesters.md
- Piracy → references/agot/agot-piracy.md
- Ruins & rebuilding → references/agot/agot-ruins.md
- Mega wars → references/agot/agot-mega-wars.md
- Coronation → references/agot/agot-coronation.md
- Bastards & bloodlines → references/agot/agot-bastards-bloodlines.md
- Magic level system → references/agot/agot-magic-level.md
- Faceless Men & secret identity → references/agot/agot-faceless-men.md

#### AGOT Extensions to Vanilla Systems
- Casus belli (AGOT changes) → references/agot/agot-ext-casus-belli.md
- Character interactions (AGOT) → references/agot/agot-ext-characters.md
- Decisions (AGOT) → references/agot/agot-ext-decisions.md
- Story cycles (AGOT) → references/agot/agot-ext-story-cycles.md
- Buildings (AGOT) → references/agot/agot-ext-buildings.md
- Culture (AGOT) → references/agot/agot-ext-culture.md
- Traits (AGOT) → references/agot/agot-ext-traits.md
- Men-at-arms (AGOT) → references/agot/agot-ext-men-at-arms.md
- GUI (AGOT) → references/agot/agot-ext-gui.md
- On actions (AGOT) → references/agot/agot-ext-on-actions.md
- Scripted effects/triggers library → references/agot/agot-ext-scripted-library.md
- GFX (AGOT) → references/agot/agot-ext-gfx.md
- Map (AGOT) → references/agot/agot-ext-map.md
- Ethnicities & DNA (AGOT) → references/agot/agot-ext-appearance.md
- Religion (AGOT) → references/agot/agot-ext-religion.md
- Governments & laws (AGOT) → references/agot/agot-ext-governments.md
- Flags (AGOT) → references/agot/agot-ext-flags.md

### I want to understand game structure
- Vanilla folder tree → references/structure/vanilla-tree.md
- Load order and overrides → references/structure/load-order.md
- Debug an error → references/structure/common-errors.md

### I want to check mod compatibility
- Compatibility patterns → references/compat/compatibility.md
- Run: `./scripts/check_compat.sh /path/to/mod_a /path/to/mod_b`

### Useful Commands
```
# Sync .info files + script_docs from game (run once after install/update)
./scripts/sync_info.sh

# Search for a trigger/effect in script_docs
grep -n "<term>" references/script_docs/effects.log references/script_docs/triggers.log

# Search for a trigger/effect in vanilla game files
grep -rn "<term>" $CK3_GAME_PATH/ --include="*.txt" | head -20

# Search with context (3 lines before/after)
./scripts/find_examples.sh $CK3_GAME_PATH "<term>"

# Index all vanilla files
./scripts/index_vanilla.sh $CK3_GAME_PATH

# Check compatibility between two mods
./scripts/check_compat.sh /path/to/mod_a /path/to/mod_b
```
