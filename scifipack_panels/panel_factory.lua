scifipack_panels.inventory_node_names = {
	-- Regular panels
	"scifipack_panels:full",
	"scifipack_panels:dash",
	"scifipack_panels:line",
	"scifipack_panels:corner",
	"scifipack_panels:corner2",
	"scifipack_panels:stripes_short",
	"scifipack_panels:stripes_long",
	"scifipack_panels:stripes_full",
	"scifipack_panels:lattice",
	"",

	-- Rusty panels
	"scifipack_panels:full_rusty",
	"scifipack_panels:dash_rusty",
	"scifipack_panels:line_rusty",
	"scifipack_panels:corner_rusty",
	"scifipack_panels:corner2_rusty",
	"scifipack_panels:stripes_short_rusty",
	"scifipack_panels:stripes_long_rusty",
	"scifipack_panels:stripes_full_rusty",
	"scifipack_panels:lattice_rusty",
	""
}

scifipack_panels.setup_factory = function(meta, preserve_index)
	local count = meta:get_int("count")
	local inv = meta:get_inventory()
	local input_stack = inv:get_stack("input", 1)

	inv:set_size("output", 20)

	if input_stack ~= nil then
		local stack_count = input_stack:get_count()
		count = count + stack_count
		if count > 99 then
			stack_count = count - 99
			count = 99
			input_stack:set_count(stack_count)
			inv:set_stack("input", 1, input_stack)
		else
			inv:set_stack("input", 1, nil)
		end
	end

	meta:set_int("count", count)

	for index, node_name in ipairs(scifipack_panels.inventory_node_names) do
		if node_name:len() and index ~= preserve_index then
			inv:set_stack("output", index, node_name .. " " .. count)
		end
	end


	meta:set_string("formspec",
		"size[9,9]"..
		"label[0,0.2;Input:]"..
		"list[context;input;1,0;1,1;]"..
		"label[0,2;The Panel Factory]"..
		"label[0,2.4;produces steel panels]"..
		"label[0,2.8;out of steel ingots or]"..
		"label[0,3.2;old steel panels.]"..
		"label[2,0.2;Output:]"..
		"list[context;output;3,0;5,4;]"..
		"list[current_player;main;0,5;8,4;]"
	);
end

scifipack_panels.check_owner = function(meta, player)
	local owner = meta:get_string("owner")
	local player_name = player:get_player_name()
	if owner == player_name then
		return true
	end
	return false
end

minetest.register_node("scifipack_panels:factory", {
	description = "Panel Factory",
	tiles = {
		"scifipack_panels_factory_top.png",
		"scifipack_panels_metal.png",
		"scifipack_panels_metal.png",
		"scifipack_panels_metal.png",
		"scifipack_panels_metal.png",
		"scifipack_panels_metal.png"
	},
	groups = {cracky = 2},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			-- Table surface
			{-0.50, 0.0, -0.50, 0.50, 0.10, 0.50},
			{-0.35, -0.20, -0.35, 0.35, 0.0, 0.35},

			-- Legs
			{-0.45, -0.50, -0.45, -0.35, 0.0, -0.35},
			{-0.45, -0.50,  0.45, -0.35, 0.0,  0.35},
			{ 0.45, -0.50,  0.45,  0.35, 0.0,  0.35},
			{ 0.45, -0.50, -0.45,  0.35, 0.0, -0.35},

			-- Drill
			{-0.02, 0.25, 0.100, 0.02, 0.43, 0.14},
			{-0.04, 0.42, 0.063, 0.04, 0.50, 0.31},
			{-0.25, 0.10, 0.310, 0.25, 0.50, 0.50}
		}
	},
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_int("count", 0)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Panel Factory (owned by " .. (placer:get_player_name() or "") .. ")")

		local inv = meta:get_inventory()
		inv:set_size("input", 1)

		scifipack_panels.setup_factory(meta)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos)
		local player_name = player:get_player_name()

		if scifipack_panels.check_owner(meta, player) then
			local count = meta:get_int("count")
			if count == 0 then
				return true
			else
				minetest.chat_send_player(player_name, "You can not dig a non-empty panel factory.")
			end
		else
			minetest.chat_send_player(player_name, "You can not dig a factory you do not own.")
		end
		return false
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not scifipack_panels.check_owner(meta, player) then
			return 0
		end

		local stack_name = stack:get_name()
		local is_panel = minetest.get_item_group(stack_name, "scifipack_panel")
		if listname == "input" and (stack_name == "default:steel_ingot" or is_panel ~= 0) then
			return 99
		end
		return 0
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)

		-- Only allow the owner to take.
		if not scifipack_panels.check_owner(meta, player) then
			return 0
		end

		return 99
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		scifipack_panels.setup_factory(meta)
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)

		if listname == "output" then
			local leftover_stack = meta:get_inventory():get_stack(listname, index)
			local preserve_index = nil

			-- Handle cases where item stacks are automatically moved into the node inventory when
			-- there is no room in the player inventory stack or it contains a different type
			if not leftover_stack:is_empty() then
				if leftover_stack:get_name() ~= scifipack_panels.inventory_node_names[index] then
					-- Preserve disallowed nodes without counting them
					preserve_index = index
					meta:set_int("count", 0)
				else
					-- Update count for normal leftovers or switched stacks of same type
					meta:set_int("count", leftover_stack:get_count())
				end
			else
				-- No leftover, set everything to 0
				meta:set_int("count", 0)
			end

			scifipack_panels.setup_factory(meta, preserve_index)
		end
	end
})
