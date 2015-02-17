function scifipack.register_linelight(color, dyecolor)
	minetest.register_node("scifipack:linelight" .. dyecolor, {
		description = color .. " Line Light",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		use_texture_alpha = true,
		light_source = LIGHT_MAX - 3,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.06, -0.44, -0.5, 0.06, -0.5, 0.5},
				{-0.5, -0.495, -0.5, 0.5, -0.495, 0.5}
			}
		},
		tiles = {
			"scifipack_linelight" .. dyecolor .. ".png",
			"scifipack_linelight" .. dyecolor .. ".png",
			"scifipack_white.png",
			"scifipack_white.png",
			"scifipack_white.png",
			"scifipack_white.png"
		},
		on_place = minetest.rotate_node,
		groups = {cracky = 2, oddly_breakable_by_hand = 3}
	})

	minetest.register_craft({
		output = "scifipack:linelight" .. dyecolor .. " 2",
		recipe = {
			{"default:obsidian_shard",	"dye:" .. dyecolor,	"default:obsidian_shard"},
			{"default:obsidian_shard",	"default:torch",	"default:obsidian_shard"},
			{"default:obsidian_shard",	"dye:" .. dyecolor,	"default:obsidian_shard"}
		}
	})
end

function scifipack.register_stairlight(color, dyecolor)
	minetest.register_node("scifipack:stairlight" .. dyecolor, {
		description = color .. " Stair Light",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		use_texture_alpha = true,
		light_source = LIGHT_MAX - 3,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.06, -0.44, 0.44, 0.06, 0.5, 0.5},
				{-0.06, -0.44, -0.5, 0.06, -0.5, 0.44},
				{-0.5, -0.5, 0.495, 0.5, 0.5, 0.495},
				{-0.5, -0.495, -0.5, 0.5, -0.495, 0.5}

			}
		},
		tiles = {
			"scifipack_linelight" .. dyecolor .. ".png",
			"scifipack_linelight" .. dyecolor .. ".png",
			"scifipack_white.png",
			"scifipack_white.png",
			"scifipack_linelight" .. dyecolor .. ".png",
			"scifipack_linelight" .. dyecolor .. ".png"
		},
		on_place = minetest.rotate_node,
		groups = {cracky = 2, oddly_breakable_by_hand = 3}
	})

	minetest.register_craft({
		output = "scifipack:stairlight" .. dyecolor,
		recipe = {
			{"dye:" .. dyecolor,	"default:torch",			"dye:" .. dyecolor},
			{"default:torch",		"default:obsidian_shard",	"default:obsidian_shard"},
			{"dye:" .. dyecolor,	"default:obsidian_shard",	"default:obsidian_shard"}
		}
	})

end

function scifipack.register_cornerlight(color, dyecolor)
	minetest.register_node("scifipack:cornerlight" .. dyecolor, {
		description = color .. " Corner Light",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		walkable = false,
		use_texture_alpha = true,
		light_source = LIGHT_MAX - 3,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.06, -0.44, -0.5, 0.06, -0.5, 0.06},
				{0.06, -0.44, -0.06, 0.5, -0.5, 0.06},
				{-0.5, -0.495, -0.5, 0.5, -0.495, 0.5}
			}
		},
		tiles = {
			"scifipack_cornerlight" .. dyecolor .. ".png",
			"scifipack_cornerlight" .. dyecolor .. ".png",
			"scifipack_white.png",
			"scifipack_white.png",
			"scifipack_white.png",
			"scifipack_white.png"
		},
		on_place = minetest.rotate_node,
		groups = {cracky = 2, oddly_breakable_by_hand = 3}
	})

	minetest.register_craft({
		output = "scifipack:cornerlight" .. dyecolor,
		recipe = {
			{"default:obsidian_shard",	"default:obsidian_shard", 	"default:obsidian_shard"},
			{"default:obsidian_shard",	"default:torch",			"dye:" .. dyecolor},
			{"default:obsidian_shard",	"dye:" .. dyecolor,			"default:obsidian_shard"}
		}
	})
end

scifipack.register_linelight("Red", "red")
scifipack.register_linelight("Yellow", "yellow")
scifipack.register_linelight("Orange", "orange")
scifipack.register_linelight("Green", "green")
scifipack.register_linelight("Cyan", "cyan")
scifipack.register_linelight("Blue", "blue")
scifipack.register_linelight("Deep Purple", "violet")
scifipack.register_linelight("Magenta", "magenta")

scifipack.register_cornerlight("Red", "red")
scifipack.register_cornerlight("Yellow", "yellow")
scifipack.register_cornerlight("Orange", "orange")
scifipack.register_cornerlight("Green", "green")
scifipack.register_cornerlight("Cyan", "cyan")
scifipack.register_cornerlight("Blue", "blue")
scifipack.register_cornerlight("Deep Purple", "violet")
scifipack.register_cornerlight("Magenta", "magenta")

scifipack.register_stairlight("Red", "red")
scifipack.register_stairlight("Yellow", "yellow")
scifipack.register_stairlight("Orange", "orange")
scifipack.register_stairlight("Green", "green")
scifipack.register_stairlight("Cyan", "cyan")
scifipack.register_stairlight("Blue", "blue")
scifipack.register_stairlight("Deep Purple", "violet")
scifipack.register_stairlight("Magenta", "magenta")

