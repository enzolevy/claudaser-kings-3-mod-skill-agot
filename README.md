# Claudaser Kings 3 — CK3 Modding Skill for Claude Code

> A mega-skill that gives Claude Code structured documentation, actionable recipes, and anti-hallucination guardrails for Crusader Kings 3 modding.

<!-- Replace YOUR_USERNAME with your GitHub username throughout this file -->

## The Problem

Paradox Script — the proprietary DSL used by Crusader Kings 3 — is poorly documented. The official wiki is scattered, and the real reference is buried in the game files themselves. LLMs confidently hallucinate triggers, effects, and syntax that don't exist, making AI-assisted CK3 modding frustrating and error-prone.

## The Solution

Claudaser Kings 3 is a Claude Code skill that embeds the entire CK3 modding wiki, wraps it with actionable recipes and utility scripts, and enforces anti-hallucination guardrails that force verification against real sources. It uses progressive disclosure — only loading what's needed for the current task — to stay within context limits.

## Features

- 📚 **Embedded CK3 modding wiki** — full reference documentation, updatable via `git pull`
- 🧑‍🍳 **Actionable recipes** for common modding tasks (events, decisions, traits, CBs, GUI, and more)
- 🧭 **Smart navigation index** — Claude Code knows which file to read for each task
- 🔍 **Utility scripts** for searching and indexing vanilla game files
- 🛡️ **Anti-hallucination guardrails** — forces verification against real sources
- 💻 **Cross-platform support** (Windows, macOS, Linux)

## Installation

### Option 1: Claude Code Plugin (recommended)

```bash
claude plugin marketplace add YOUR_USERNAME/claudaser-kings-3-mod-skill
```

### Option 2: Clone to personal skills

```bash
git clone https://github.com/YOUR_USERNAME/claudaser-kings-3-mod-skill.git \
  ~/.claude/skills/ck3-modding
```

### Option 3: Clone to project skills

```bash
git clone https://github.com/YOUR_USERNAME/claudaser-kings-3-mod-skill.git \
  .claude/skills/ck3-modding
```

## Setup

After installing, configure your game paths. See [references/setup.md](references/setup.md) for detailed instructions for Windows, macOS, and Linux.

## How It Works

- **SKILL.md** is the entrypoint and router. It's loaded when the skill triggers and directs Claude Code to the right reference file.
- **references/wiki/** contains the embedded CK3 modding wiki (loaded on-demand per task).
- **references/patterns/** contains actionable recipes — the skill's real value-add over the raw wiki.
- **references/structure/** documents the game's file structure, load order, and common errors.
- **scripts/** contains utility tools executed directly, without loading into context.
- **Progressive disclosure**: Claude Code only loads what it needs for the current task, keeping context usage efficient.

## Repo Structure

```
claudaser-kings-3-mod-skill/
├── SKILL.md                              # Entrypoint: frontmatter + navigation index
├── README.md                             # This file
│
├── references/
│   ├── setup.md                          # First-time configuration guide (all 3 OS)
│   │
│   ├── wiki/                             # Snapshot of jesec/ck3-modding-wiki
│   │   └── wiki_pages/                   # All CK3 wiki pages in markdown
│   │       ├── Scripting.md
│   │       ├── Effects.md
│   │       ├── Triggers.md
│   │       ├── Scopes.md
│   │       ├── Event_modding.md
│   │       ├── Mod_structure.md
│   │       └── ... (50+ pages)
│   │
│   ├── patterns/                         # Practical recipes (THE VALUE-ADD)
│   │   ├── mod-setup.md                  # Create a mod from scratch
│   │   ├── events.md                     # Events, event chains, on_actions
│   │   ├── decisions.md                  # Decisions, conditions, AI behavior
│   │   ├── traits.md                     # Traits, triggered modifiers
│   │   ├── characters.md                 # Character interactions, schemes
│   │   ├── localization.md               # Localization conventions
│   │   ├── casus-belli.md                # Custom CBs, war logic
│   │   ├── culture-religion.md           # Doctrines, tenets, innovations
│   │   ├── gui.md                        # UI modding (widgets, windows)
│   │   └── gfx.md                        # Graphical assets, portraits, CoA
│   │
│   └── structure/
│       ├── vanilla-tree.md               # Game folder tree
│       ├── load-order.md                 # Loading, override, replace_path
│       └── common-errors.md              # Common errors, debugging
│
└── scripts/
    ├── index_vanilla.sh                  # List vanilla files by folder
    └── find_examples.sh                  # Search vanilla for examples
```

## Updating the Wiki

The `references/wiki/` folder contains a snapshot of the CK3 modding wiki. To get the latest version:

```bash
cd references/wiki/ && git pull origin master
```

Recommended before a major modding session.

## Contributing

Contributions are welcome! You can help by:

- **Adding new patterns** — follow the format in existing `references/patterns/` files
- **Fixing errors** — if you spot incorrect syntax or outdated information
- **Improving documentation** — better examples, clearer explanations
- **Reporting issues** — open an issue if something doesn't work as expected

Pattern files should follow the established format: context → minimal template → vanilla example → variants → checklist → pitfalls.

## Future Plans

- 🐉 **AGOT sub-skill** — A Game of Thrones mod-specific conventions and systems
- 🔧 **Advanced Paradox Script parser** / CLI tool
- 📖 **More pattern recipes** based on community feedback

## Acknowledgments

This skill stands on the shoulders of giants:

### jesec/ck3-modding-wiki

The embedded wiki documentation is a snapshot of [jesec/ck3-modding-wiki](https://github.com/jesec/ck3-modding-wiki), an incredible project that maintains a daily-updated, git-versioned markdown archive of the official CK3 Paradox Wiki modding pages. This project would not exist without their work. All wiki content is published under the [Creative Commons Attribution-Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

### Paradox Interactive

For creating Crusader Kings 3 and its modding framework, and for fostering a modding community that has produced incredible content.

### The CK3 Modding Community

For building and maintaining the wiki documentation over the years. Every page in the wiki represents hours of community effort documenting an often cryptic scripting language.

## License

The wiki content in `references/wiki/` is licensed under [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/) (original content from the Paradox Wiki).

All original content (SKILL.md, patterns, scripts, structure docs) is licensed under [MIT](LICENSE).
