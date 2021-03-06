-- Load translation library if intllib is installed

local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter(minetest.get_current_modname())
else
	S = function(s) return s end
end

-- Node will be called <modname>:stair_<subname>

function register_stair(modname, subname, recipeitem, groups, images, description, drop, light)
	return stairsplus:register_stair(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_stair(modname, subname, recipeitem, fields)
	local defs = {
		[""] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_half"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0, 0, 0.5},
					{-0.5, 0, 0, 0, 0.5, 0.5},
				},
			},
		},
		["_right_half" ]= {
			node_box = {
				type = "fixed",
				fixed = {
					{0, -0.5, -0.5, 0.5, 0, 0.5},
					{0, 0, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_inner"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
					{-0.5, 0, -0.5, 0, 0.5, 0},
				},
			},
		},
		["_outer"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
					{-0.5, 0, 0, 0, 0.5, 0.5},
				},
			},
		},
		["_alt"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.5, -0.5, 0.5, 0, 0},
					{-0.5, 0, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_alt_1"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.0625, -0.5, 0.5, 0, 0},
					{-0.5, 0.4375, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_alt_2"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.125, -0.5, 0.5, 0, 0},
					{-0.5, 0.375, 0, 0.5, 0.5, 0.5},
				},
			},
		},
		["_alt_4"] = {
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5, -0.25, -0.5, 0.5, 0, 0},
					{-0.5, 0.25, 0, 0.5, 0.5, 0.5},
				},
			},
		},
	}

	local desc = S("%s Stairs"):format(fields.description)
	for alternate, def in pairs(defs) do
		def.drawtype = "nodebox"
		def.paramtype = "light"
		def.paramtype2 = "facedir"
		def.on_place = minetest.rotate_node
		for k, v in pairs(fields) do
			def[k] = v
		end
		def.description = desc
		if fields.drop then
			def.drop = modname..":stair_"..fields.drop..alternate
		end
		minetest.register_node(":"..modname..":stair_"..subname..alternate, def)
	end
	minetest.register_alias(":stairs:stair_"..subname, modname..":stair_"..subname)

	-- Some saw-less recipes.
	
		minetest.register_craft({
			output = "moreblocks:stair_" .. subname .. " 8",
			recipe = {
				{recipeitem, "", ""},
				{recipeitem, recipeitem, ""},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		minetest.register_craft({
			output = "moreblocks:stair_" .. subname .. " 8",
			recipe = {
				{"", "", recipeitem},
				{"", recipeitem, recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})
		minetest.register_craft({
			output = "moreblocks:stair_" .. subname,
			recipe = {
				{"moreblocks:panel_" .. subname},
				{"moreblocks:slab_" .. subname},
			},
		})
		minetest.register_craft({
			output = "moreblocks:stair_" .. subname .. "_outer",
			recipe = {
				{"moreblocks:micro_" .. subname},
				{"moreblocks:slab_" .. subname},
			},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:stair_" .. subname .. "_half",
			recipe = {"moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:stair_" .. subname .. "_right_half",
			recipe = {"moreblocks:stair_" .. subname .. "_half"},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:stair_" .. subname .. "_half",
			recipe = {"moreblocks:stair_" .. subname .. "_right_half"},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:stair_" .. subname,
			recipe = {"moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:stair_" .. subname .. "_inner",
			recipe = {"moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:stair_" .. subname .. "_outer",
			recipe = {"moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname, "moreblocks:micro_" .. subname},
		})
		minetest.register_craft({
			type = "shapeless",
			output = "moreblocks:stair_" .. subname,
			recipe = {"moreblocks:panel_" .. subname, "moreblocks:panel_" .. subname, "moreblocks:panel_" .. subname},
		})
end

