function scifipack_neon.register_linelight(color, dyecolor, colorstring)
	minetest.register_node("scifipack_neon:linelight" .. dyecolor, {
		description = color .. " Neon Line Light",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		use_texture_alpha = true,
		light_source = LIGHT_MAX - 3,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.055, -0.44, -0.5, 0.055, -0.5, 0.5},
				{-0.5, -0.495, -0.5, 0.5, -0.495, 0.5}
			}
		},
		tiles = {
			"scifipack_neon_linelight" .. dyecolor .. ".png",
			"scifipack_neon_linelight" .. dyecolor .. ".png",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255"
		},
		on_place = minetest.rotate_node,
		groups = {cracky = 2, oddly_breakable_by_hand = 3}
	})

	minetest.register_craft({
		output = "scifipack_neon:linelight" .. dyecolor .. " 2",
		recipe = {
			{"default:obsidian_shard",	"dye:" .. dyecolor,	"default:obsidian_shard"},
			{"default:obsidian_shard",	"default:torch",	"default:obsidian_shard"},
			{"default:obsidian_shard",	"dye:" .. dyecolor,	"default:obsidian_shard"}
		}
	})
end

function scifipack_neon.register_stairlight(color, dyecolor, colorstring)
	minetest.register_node("scifipack_neon:stairlight" .. dyecolor, {
		description = color .. " Neon Stair Light",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		use_texture_alpha = true,
		light_source = LIGHT_MAX - 3,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.055, -0.44, 0.44, 0.055, 0.5, 0.5},
				{-0.055, -0.44, -0.5, 0.055, -0.5, 0.44},
				{-0.5, -0.5, 0.495, 0.5, 0.5, 0.495},
				{-0.5, -0.495, -0.5, 0.5, -0.495, 0.5}

			}
		},
		tiles = {
			"scifipack_neon_linelight" .. dyecolor .. ".png",
			"scifipack_neon_linelight" .. dyecolor .. ".png",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_linelight" .. dyecolor .. ".png",
			"scifipack_neon_linelight" .. dyecolor .. ".png"
		},
		on_place = minetest.rotate_node,
		groups = {cracky = 2, oddly_breakable_by_hand = 3}
	})

	minetest.register_craft({
		output = "scifipack_neon:stairlight" .. dyecolor,
		recipe = {
			{"dye:" .. dyecolor,	"default:torch",			"dye:" .. dyecolor},
			{"default:torch",		"default:obsidian_shard",	"default:obsidian_shard"},
			{"dye:" .. dyecolor,	"default:obsidian_shard",	"default:obsidian_shard"}
		}
	})

end

function scifipack_neon.register_cornerlight(color, dyecolor, colorstring)
	minetest.register_node("scifipack_neon:cornerlight" .. dyecolor, {
		description = color .. " Neon Corner Light",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		use_texture_alpha = true,
		light_source = LIGHT_MAX - 3,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.055, -0.44, -0.5, 0.055, -0.5, 0.055},
				{0.055, -0.44, -0.055, 0.5, -0.5, 0.055},
				{-0.5, -0.495, -0.5, 0.5, -0.495, 0.5}
			}
		},
		tiles = {
			"scifipack_neon_cornerlight" .. dyecolor .. ".png",
			"scifipack_neon_cornerlight" .. dyecolor .. ".png",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255",
			"scifipack_neon_white.png^[colorize:" .. colorstring .. ":255"
		},
		on_place = minetest.rotate_node,
		groups = {cracky = 2, oddly_breakable_by_hand = 3}
	})

	minetest.register_craft({
		output = "scifipack_neon:cornerlight" .. dyecolor,
		recipe = {
			{"default:obsidian_shard",	"default:obsidian_shard", 	"default:obsidian_shard"},
			{"default:obsidian_shard",	"default:torch",			"dye:" .. dyecolor},
			{"default:obsidian_shard",	"dye:" .. dyecolor,			"default:obsidian_shard"}
		}
	})
end

function scifipack_neon.register_all_lights(color, dyecolor, colorstring)
	scifipack_neon.register_linelight(color, dyecolor, colorstring)
	scifipack_neon.register_cornerlight(color, dyecolor, colorstring)
	scifipack_neon.register_stairlight(color, dyecolor, colorstring)
end

scifipack_neon.register_all_lights("Red", "red", "#ffe6e6")
scifipack_neon.register_all_lights("Yellow", "yellow", "#ffffe6")
scifipack_neon.register_all_lights("Orange", "orange", "#fff2e6")
scifipack_neon.register_all_lights("Green", "green", "#e6ffe6")
scifipack_neon.register_all_lights("Cyan", "cyan", "#e6ffff")
scifipack_neon.register_all_lights("Blue", "blue", "#e6f7ff")
scifipack_neon.register_all_lights("Deep Purple", "violet", "#e9d9ff")
scifipack_neon.register_all_lights("Magenta", "magenta", "#ffe6fd")
