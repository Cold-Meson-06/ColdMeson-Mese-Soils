-- Mese sand mod v0.0.1 by wheatley_555 (Fernando M)
-- This mod add two new soils for papyrus and cactus 
-- Papyrus and Cactus grow whit 1 node +
-- 1 block per second

-- For cactus grow fast

minetest.register_abm({
	nodenames = {"default:cactus"},
	neighbors = {"mese_sand:new_sand"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		pos.y = pos.y-1
		local name = minetest.get_node(pos).name
		if minetest.get_item_group(name, "sand") ~= 0 then
			pos.y = pos.y+1
			local height = 0
			while minetest.get_node(pos).name == "default:cactus" and height < 5 do
				height = height+1
				pos.y = pos.y+1
			end
			if height < 5 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:cactus"})
				end
			end
		end
	end,
})

--For papyrus grow fast

minetest.register_abm({
	nodenames = {"default:papyrus"},
	neighbors = {"mese_sand:new_dirt"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		pos.y = pos.y-1
		local name = minetest.get_node(pos).name
		if name == "mese_sand:new_dirt" then
			if minetest.find_node_near(pos, 3, {"group:water"}) == nil then
				return
			end
			pos.y = pos.y+1
			local height = 0
			while minetest.get_node(pos).name == "default:papyrus" and height < 5 do
				height = height+1
				pos.y = pos.y+1
			end
			if height < 5 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:papyrus"})
				end
			end
		end
	end,
})

--Register all nodes and craftitens


minetest.register_craftitem("mese_sand:power_loader", {
	description = "Power loader",
	inventory_image = "PL.png",
})

minetest.register_node("mese_sand:new_sand", {
	description = "Sand Enhiched whit Mese",
	tiles = {"MS.png"},
	is_ground_content = true,
	light_source = 5,
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("mese_sand:new_dirt", {
	description = "Dirt Enhiched whit Mese",
	tiles = {"MD.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

-- Register crafts

local ms = "default:mese"
local dt = "default:dirt"
local ds = "default:desert_sand"
local pl = "mese_sand:power_loader"
local os = "default:obsidian"
local st = "default:stone"

minetest.register_craft({
	output = 'mese_sand:new_dirt',
	recipe = {
		{ms, pl, ms},
		{pl, dt, pl},
		{ms, pl, ms}
	}
})

minetest.register_craft({
	output = 'mese_sand:new_sand',
	recipe = {
		{ms, pl, ms},
		{pl, ds, pl},
		{ms, pl, ms}
	}
})

minetest.register_craft({
	output = pl,
	recipe = {
		{os, st, os},
		{st, ms, st},
		{os, st, os}
	}
})

print("Mese Sand v0.0.1 by wheatley_555 Loaded!")






