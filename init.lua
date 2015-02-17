scifipack = {}

dofile(minetest.get_modpath("scifipack").."/lights.lua")

minetest.register_node("scifipack:hexfloor", {
	description = "Hexagon Floor",
	tiles = {"scifipack_hexfloor.png"},
	groups = {cracky = 2, level = 1}
})

minetest.register_craft({
	output = "scifipack:hexfloor 4",
	recipe = {
		{"default:obsidian_shard",	"default:steel_ingot",		"default:obsidian_shard"},
		{"default:steel_ingot",		"default:obsidian_shard",	"default:steel_ingot"},
		{"default:obsidian_shard",	"default:steel_ingot",		"default:obsidian_shard"}
	}
})

