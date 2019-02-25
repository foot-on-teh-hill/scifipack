scifipack_panels.setup_factory = function(meta)
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

	-- Regular panels
	inv:set_stack("output", 1 ,"scifipack_panels:full " .. count)
	inv:set_stack("output", 2 ,"scifipack_panels:dash " .. count)
	inv:set_stack("output", 3 ,"scifipack_panels:line " .. count)
	inv:set_stack("output", 4 ,"scifipack_panels:corner " .. count)
	inv:set_stack("output", 5 ,"scifipack_panels:corner2 " .. count)
	inv:set_stack("output", 6 ,"scifipack_panels:stripes_short " .. count)
	inv:set_stack("output", 7 ,"scifipack_panels:stripes_long " .. count)
	inv:set_stack("output", 8 ,"scifipack_panels:stripes_full " .. count)
	inv:set_stack("output", 9 ,"scifipack_panels:lattice " .. count)

	-- Rusty panels
	inv:set_stack("output", 11 ,"scifipack_panels:full_rusty " .. count)
	inv:set_stack("output", 12 ,"scifipack_panels:dash_rusty " .. count)
	inv:set_stack("output", 13 ,"scifipack_panels:line_rusty " .. count)
	inv:set_stack("output", 14 ,"scifipack_panels:corner_rusty " .. count)
	inv:set_stack("output", 15 ,"scifipack_panels:corner2_rusty " .. count)
	inv:set_stack("output", 16 ,"scifipack_panels:stripes_short_rusty " .. count)
	inv:set_stack("output", 17 ,"scifipack_panels:stripes_long_rusty " .. count)
	inv:set_stack("output", 18 ,"scifipack_panels:stripes_full_rusty " .. count)
	inv:set_stack("output", 19 ,"scifipack_panels:lattice_rusty " .. count)

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
		local inv = meta:get_inventory()
		local input_stack = inv:get_stack(listname,  index)
		if not input_stack:is_empty() and input_stack:get_name() ~= stack:get_name() then
			local player_inv = player:get_inventory()
			if player_inv:room_for_item("main", input_stack) then
				return input_stack
			end
			scifipack_panels.setup_factory(meta) 
			return
		end	
		if listname == "output" then
			local stack_count = stack:get_count()
			local count = meta:get_int("count")
			count = count - stack_count
			if count < 0 then
				count = 0
			end
			meta:set_int("count", count)
			scifipack_panels.setup_factory(meta)
		end
	end
})
