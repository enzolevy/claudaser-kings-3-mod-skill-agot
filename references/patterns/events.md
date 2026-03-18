# Creating Events — Practical Recipe

## What You Need to Know First
Events are the core of CK3 modding. Every event needs a namespace, an ID, and must be fired by something (on_action, decision, another event, etc.). Events do NOT fire automatically — they must be triggered.
> Reference docs: references/wiki/wiki_pages/Event_modding.md

## Minimal Template

```
namespace = my_mod

# A basic character event
my_mod.0001 = {
	type = character_event
	title = my_mod.0001.t
	desc = my_mod.0001.desc

	theme = diplomacy

	left_portrait = {
		character = root
		animation = personality_rational
	}

	trigger = {
		is_available_adult = yes
	}

	immediate = {
		# Effects that happen when the event fires (before player sees it)
	}

	option = {
		name = my_mod.0001.a
		add_gold = 100
	}
}
```

### Required Localization (localization/english/my_mod_events_l_english.yml)
```
l_english:
 my_mod.0001.t: "Event Title"
 my_mod.0001.desc: "This is what happened to [ROOT.Char.GetName]."
 my_mod.0001.a: "Interesting!"
```

## Annotated Vanilla Example
<!-- TODO: Add a real vanilla example. Run:
grep -rn "type = character_event" $CK3_GAME_PATH/events/ | head -5
and annotate the simplest result. -->

## Common Variants

### Event with multiple options
```
my_mod.0002 = {
	type = character_event
	title = my_mod.0002.t
	desc = my_mod.0002.desc
	theme = intrigue

	left_portrait = {
		character = root
		animation = worry
	}

	option = {
		name = my_mod.0002.a
		add_gold = 100
		stress_impact = {
			greedy = medium_stress_loss
		}
	}

	option = {
		name = my_mod.0002.b
		add_piety = 50
		stress_impact = {
			generous = medium_stress_loss
		}
	}
}
```

### Firing an event from an on_action
Create `common/on_actions/my_mod_on_actions.txt`:
```
on_yearly_pulse = {
	on_actions = {
		my_mod_yearly_events
	}
}

my_mod_yearly_events = {
	random_events = {
		chance_of_no_event = {
			value = 75
		}
		100 = my_mod.0001
		50 = my_mod.0002
	}
}
```

### Event chain (one event fires another)
```
my_mod.0010 = {
	type = character_event
	title = my_mod.0010.t
	desc = my_mod.0010.desc
	theme = diplomacy

	left_portrait = {
		character = root
		animation = happiness
	}

	option = {
		name = my_mod.0010.a
		# Save a scope for use in the next event
		random_child = {
			limit = { is_adult = yes }
			save_scope_as = chosen_child
		}
		trigger_event = {
			id = my_mod.0011
			days = 3
		}
	}
}

my_mod.0011 = {
	type = character_event
	title = my_mod.0011.t
	desc = my_mod.0011.desc
	theme = diplomacy

	left_portrait = {
		character = scope:chosen_child
		animation = personality_bold
	}

	option = {
		name = my_mod.0011.a
		scope:chosen_child = {
			add_gold = 50
		}
	}
}
```

### Scripted effects defined locally in event file
```
namespace = my_mod

scripted_effect my_reward_effect = {
	add_gold = 100
	add_prestige = 50
}

my_mod.0020 = {
	type = character_event
	# ...
	option = {
		name = my_mod.0020.a
		my_reward_effect = yes
	}
}
```

## Checklist
- [ ] Event file in `events/` folder with `.txt` extension
- [ ] `namespace = X` on the first line of the file
- [ ] Event ID matches namespace: `X.0001`
- [ ] Localization keys for title (`.t`), description (`.desc`), and each option (`.a`, `.b`, etc.)
- [ ] ALL files encoded as UTF-8 BOM (event .txt files AND localization .yml files)
- [ ] Event is fired from somewhere (on_action, decision, another event, `trigger_event`)
- [ ] Test with `event my_mod.0001` in console

## Common Pitfalls
- **Event never fires**: Events must be triggered by something — they don't fire on their own. Use on_actions, decisions, or `trigger_event`
- **Namespace mismatch**: Event ID `my_mod.0001` requires `namespace = my_mod` at the top of the file
- **Effects in trigger block**: `trigger = {}` only accepts triggers, not effects. Put effects in `immediate = {}` or inside `option = {}`
- **Scope confusion**: `root` in an event is the character who received the event, not necessarily the player
- **Using scope: with root/prev**: Never write `scope:root` — just write `root`. The `scope:` prefix is only for saved scopes
- **Localization error spam**: If using dynamic loc like `[ROOT.Char.GetName]`, make sure the scope exists. Use `ROOT.Char` not just `ROOT`
- **Missing portraits**: If `character = scope:someone` is used in a portrait block, that scope must be saved in `immediate = {}` before the player sees the event
- **File encoding**: Event .txt files MUST be UTF-8 with BOM, not just localization. Without BOM, the game may fail to parse the file correctly
- **Removing gold**: Use `remove_short_term_gold = 50`, not `add_gold = -50`. Negative add_gold causes a "missing perspective" error
- **Loc scope prefix**: In localization, do NOT use `scope:` prefix for saved scopes. Write `[the_merchant.GetName]`, not `[scope:the_merchant.GetName]`
- **Delayed events and loc**: When using `trigger_event = { id = X days = Y }`, saved scopes are available to script but NOT to localization in the target event. If you need to reference a saved scope in loc, fire the event immediately (`trigger_event = X`) or re-save the scope in the target event's `immediate` block
