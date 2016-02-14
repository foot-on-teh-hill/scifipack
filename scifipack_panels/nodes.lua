scifipack_panels.register_panel = function(description_, node_name, texture_path, is_corner) 
	local node_definition =  {
		description = description_,
		paramtype = "light",
		paramtype2 = "facedir",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -0.44, 0.5}
			}
		},
		on_place = minetest.rotate_node,
		groups = {cracky = 2, scifipack_panel = 1}
	}
	if is_corner == nil then
		node_definition.tiles = {
			texture_path,
			texture_path,
			"scifipack_panels_metal.png",
			"scifipack_panels_metal.png",
			texture_path .. "^[transformFX",
			texture_path
		}
	else
		node_definition.tiles = {
			texture_path,
			texture_path,
			texture_path,
			"scifipack_panels_metal.png",
			"scifipack_panels_metal.png",
			texture_path
		}
	end

	-- Create rusty variant
	local node_definition_rusty = {}
	for k, v in pairs(node_definition) do
		if k == "tiles" then
			local tiles = { }
			for tile_index, tile in pairs(node_definition.tiles) do
				tiles[tile_index] = tile .. "^[colorize:#26130a:160"
			end
			node_definition_rusty.tiles = tiles
		else
			node_definition_rusty[k] = v
		end
	end
	node_definition_rusty.description = "Rusty " .. node_definition_rusty.description

	minetest.register_node("scifipack_panels:" .. node_name, node_definition)
	minetest.register_node("scifipack_panels:" .. node_name .. "_rusty", node_definition_rusty)
end

scifipack_panels.register_panel("Steel Full Panel", "full", "scifipack_panels_full.png")
scifipack_panels.register_panel("Steel Dash Panel", "dash", "scifipack_panels_dash.png")
scifipack_panels.register_panel("Steel Line Panel", "line", "scifipack_panels_line.png")
scifipack_panels.register_panel("Steel Corner Panel", "corner", "scifipack_panels_corner.png", true)
scifipack_panels.register_panel("Steel Short Stripes Panel", "stripes_short", "scifipack_panels_stripes_short.png")
scifipack_panels.register_panel("Steel Long Stripes Panel", "stripes_long", "scifipack_panels_stripes_long.png")
scifipack_panels.register_panel("Steel Full Stripes Panel", "stripes_full", "scifipack_panels_stripes_full.png")
scifipack_panels.register_panel("Steel Lattice Panel", "lattice", "scifipack_panels_lattice.png")
