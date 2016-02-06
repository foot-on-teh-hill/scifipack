minetest.register_craft({
	output = "scifipack_building:hexfloor 4",
	recipe = {
		{"default:obsidian_shard",	"default:steel_ingot",		"default:obsidian_shard"},
		{"default:steel_ingot",		"default:obsidian_shard",	"default:steel_ingot"},
		{"default:obsidian_shard",	"default:steel_ingot",		"default:obsidian_shard"}
	}
})

minetest.register_craft({
	output = "scifipack_building:steelpanel1 9",
	recipe = {
		{"default:obsidian_shard"},
		{"default:steelblock"},
		{"default:obsidian_shard"}
	}
})

minetest.register_craft({
	output = "scifipack_building:frostyglowglass",
	recipe = {
		{"default:mese_crystal"},
		{"default:glass"},
		{"dye:blue"}
	}
})
