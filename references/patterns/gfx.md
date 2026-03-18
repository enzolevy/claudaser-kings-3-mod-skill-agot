# Adding Graphical Assets — Practical Recipe

## What You Need to Know First
CK3 uses DDS files for most textures and has specific requirements for different asset types. Coat of arms have their own scripting system. Portrait modifications use DNA modifiers.
> Reference docs: references/wiki/wiki_pages/Graphical_assets.md, references/wiki/wiki_pages/Coat_of_arms_modding.md

## Minimal Template — Custom Trait Icon

### gfx/interface/icons/traits/my_trait.dds
- Size: 60x60 pixels
- Format: DDS (BC3/DXT5 with alpha) or PNG
- Save with mipmaps for best quality

## Minimal Template — Custom Coat of Arms

### common/coat_of_arms/coat_of_arms/my_coa.txt
```
my_custom_title_coa = {
	pattern = "pattern_solid"
	color1 = "blue"
	color2 = "white"

	colored_emblem = {
		texture = "ce_lion_passant.dds"
		color1 = "yellow"
		instance = {
			position = { 0.5 0.5 }
			scale = { 0.8 0.8 }
		}
	}
}
```

If the CoA key matches a title, dynasty, or house key (e.g., `d_my_duchy`), it's automatically used.

## Annotated Vanilla Example
<!-- TODO: Add a real vanilla CoA example. Run:
grep -rn "colored_emblem" $CK3_GAME_PATH/common/coat_of_arms/ | head -5
-->

## Common Variants

### Decision illustration
Place a DDS image at:
```
gfx/interface/illustrations/decisions/my_decision_image.dds
```
Reference in decision:
```
picture = {
	reference = "gfx/interface/illustrations/decisions/my_decision_image.dds"
}
```

### Event background
Standard event backgrounds are defined in `gui/event_windows/`. Custom backgrounds go in `gfx/interface/illustrations/event_scenes/`.

### Portrait DNA modifier
```
# gfx/portraits/portrait_modifiers/my_modifiers.txt
my_custom_look = {
	usage = game
	priority = 50
	my_custom_look = {
		dna_modifiers = {
			accessory = {
				mode = add
				gene = headgear
				template = western_imperial
				value = 1.0
			}
		}
		weight = {
			base = 0
			modifier = {
				add = 100
				has_character_flag = my_custom_look
			}
		}
	}
}
```
Apply with: `add_character_flag = my_custom_look`

### Portrait palettes
Located in `gfx/portraits/`:
- `hair_palette.dds` — 256x256, 8.8.8 BGR 24bpp DDS, no mipmaps
- `skin_palette.dds` — same format
- `eye_palette.dds` — same format

### CoA with multiple emblems
```
my_complex_coa = {
	pattern = "pattern_vertical_split_01"
	color1 = "red"
	color2 = "white"

	textured_emblem = {
		texture = "te_griffin_01.dds"
		mask = { 1 }
		instance = {
			position = { 0.25 0.5 }
			scale = { 0.5 0.5 }
		}
	}

	colored_emblem = {
		texture = "ce_crown.dds"
		color1 = "yellow"
		instance = {
			position = { 0.75 0.25 }
			scale = { 0.3 0.3 }
			depth = 5.0
		}
	}
}
```

## Checklist
- [ ] DDS files saved in correct format (BC3/DXT5 for icons with alpha, BC1/DXT1 for opaque)
- [ ] Correct dimensions for the asset type (60x60 for trait icons, 256x256 for palettes)
- [ ] CoA definitions in `common/coat_of_arms/coat_of_arms/`
- [ ] CoA key matches title/dynasty/house key for auto-assignment
- [ ] Test CoA in the in-game CoA designer (`coat_of_arms_designer` console command)

## Common Pitfalls
- **DDS format**: Use Intel Texture Works (Photoshop) or GIMP DDS plugin. Wrong compression format causes visual glitches
- **Palette dimensions**: Portrait palettes must be exactly 256x256
- **CoA patterns**: Always include a `pattern` to avoid masking issues with textured emblems
- **PNG fallback**: The game accepts PNG in many places, which is easier to work with during development. Convert to DDS for release
- **CoA designer**: Use the in-game designer to prototype, then export the script. The designer has some limitations vs manual scripting
