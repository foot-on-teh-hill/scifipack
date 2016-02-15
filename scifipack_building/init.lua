local stair_nodes = {
	["hexfloor"] = {
		description = "Hexagon Floor",
		tiles = {"scifipack_building_hexfloor.png"},
		groups = {cracky = 2, level = 1}
	},
	["steelpanel1"] = {
		description = "Steel Panel 1",
		tiles = {"scifipack_building_steelpanel1.png"},
		groups = {cracky = 2}
	},
	["frostyglowglass"] = {
		description = "Frosty Glow Glass",
		tiles = {"scifipack_building_frostyglowglass.png"},
		use_texture_alpha = true,
		paramtype = "light",
		light_source = LIGHT_MAX,
		groups = {
			cracky = 3,
			choppy = 3,
			oddly_breakable_by_hand = 3
		}
	}
}

for name, definition in pairs(stair_nodes) do
	minetest.register_node("scifipack_building:" .. name, definition)
end

-- Moreblocks support
if minetest.get_modpath("moreblocks") ~= nil then
	for name, definition in pairs(stair_nodes) do
		-- Make a shallow copy of the definition
		local stairs_definition = {}
		for k, v in pairs(definition) do 
			stairs_definition[k] = v
		end
		-- Make a shallow copy of the groups
		local stairs_groups = { not_in_craft_guide = 1 }
		if (stairs_definition["groups"] ~= nil) then
			for k, v in pairs(stairs_definition["groups"]) do 
				stairs_groups[k] = v
			end
		end
		stairs_definition["groups"] = stairs_groups
		stairsplus:register_all("scifipack_building", name, "scifipack_building:" .. name, stairs_definition)
	end
end

dofile(minetest.get_modpath("scifipack_building").."/crafting.lua")
dofile(minetest.get_modpath("scifipack_building").."/aliases.lua")
