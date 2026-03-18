# Creating Traits — Practical Recipe

## What You Need to Know First
Traits modify character attributes, opinions, personality, and other parameters. They're defined in `common/traits/` and need localization and an icon.
> Reference docs: references/wiki/wiki_pages/Trait_modding.md, references/wiki/wiki_pages/Modifier_list.md

## Minimal Template

### common/traits/my_traits.txt
```
my_custom_trait = {
	# Attribute modifiers
	diplomacy = 2
	martial = -1
	intrigue = 1

	# Opinion modifier from this trait holder's perspective
	opposite = my_opposite_trait

	# Trait metadata
	category = personality

	# Icon: gfx/interface/icons/traits/my_custom_trait.dds
}

my_opposite_trait = {
	diplomacy = -2
	martial = 1
	intrigue = -1

	opposite = my_custom_trait
	category = personality
}
```

### Localization (localization/english/my_traits_l_english.yml)
```
l_english:
 trait_my_custom_trait: "My Custom Trait"
 trait_my_custom_trait_desc: "This character has a custom trait that boosts diplomacy."
 trait_my_opposite_trait: "My Opposite Trait"
 trait_my_opposite_trait_desc: "This character has the opposite of the custom trait."
```

### Icon
Place a .dds icon at: `gfx/interface/icons/traits/my_custom_trait.dds`

Default icon size is 60x60 pixels.

## Annotated Vanilla Example
<!-- TODO: Add a real vanilla example. Run:
grep -rn "category = personality" $CK3_GAME_PATH/common/traits/ | head -5
and annotate the simplest result. -->

## Common Variants

### Genetic trait (inheritable)
```
my_genetic_trait = {
	health = 0.5
	fertility = 0.1
	diplomacy = 2

	genetic = yes
	inherit_chance = 50
	birth = 5
	good = yes

	category = health
}
```

### Trait with same-trait opinion bonus
```
my_social_trait = {
	diplomacy = 2

	# Characters who share this trait get +10 opinion of each other
	same_opinion = 10
	# Variant: same_opinion_if_same_faith = 15 (only if also same faith)

	compatibility = {
		gregarious = 10
		shy = -10
	}

	category = personality
}
```

### Trait with triggered opinion (faith-based virtues/sins)
`triggered_opinion` is for doctrine-linked traits (virtues/sins). It requires a `parameter` referencing a doctrine parameter. Without `parameter`, the tooltip breaks.
```
my_pious_trait = {
	learning = 3

	# Only use triggered_opinion with a doctrine parameter
	triggered_opinion = {
		parameter = some_doctrine_parameter
		opinion_modifier = my_opinion_modifier
		same_faith = yes
		ignore_opinion_value_if_same_trait = yes
	}

	category = personality
}
```

### Trait with level variants (like education traits)
```
my_skill_1 = {
	martial = 2
	category = lifestyle
	# Level 1
}

my_skill_2 = {
	martial = 4
	category = lifestyle
	# Level 2
}

my_skill_3 = {
	martial = 6
	category = lifestyle
	# Level 3
}
```

### Immortal trait
```
my_immortal_trait = {
	immortal = yes
	health = 5
	category = health
}
```
Use `set_immortal_age = 30` effect to keep them visually young.

## Checklist
- [ ] Trait file in `common/traits/` with `.txt` extension
- [ ] Localization: `trait_<key>` and `trait_<key>_desc`
- [ ] Icon at `gfx/interface/icons/traits/<key>.dds` (60x60 pixels)
- [ ] Category set (personality, education, health, etc.)
- [ ] Test: `effect add_trait = my_custom_trait` in console

## Common Pitfalls
- **Same-trait opinion**: Use `same_opinion = 10`, NOT `triggered_opinion`. `triggered_opinion` is for faith-based virtue/sin mechanics and requires a `parameter` referencing a doctrine. Without it, you get a broken `TRAIT_DESC_POSITIVE_FOR_THEM` tooltip
- **Trait name conflict**: If your trait key matches a vanilla trait, it will override it. Use a unique prefix
- **Missing icon**: The game will show a blank icon. Default path is `gfx/interface/icons/traits/<trait_key>.dds`
- **Localization keys**: Default is `trait_<key>`, not just `<key>`. This is different from decisions!
- **Opposite traits**: If you set `opposite = X`, a character can't have both traits simultaneously
- **Genetic traits**: Set `genetic = yes` for proper inheritance behavior. Without it, `inherit_chance` uses simpler logic
- **Dynamic names/icons**: If using `name = { first_valid = { ... } }`, include a fallback for `NOT = { exists = this }` to avoid errors when the trait is displayed without a character context
