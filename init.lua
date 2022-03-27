minetest.log("action"," ---- Dark Age Version 1.3 is Loading! ---- ")

darkage = {}; -- Create darkage namespace

darkage.formbg = (default.gui_bg or "")..
	(default.gui_bg_img or "")..
	(default.gui_slots or "")

local MODPATH = minetest.get_modpath(minetest.get_current_modname())..DIR_DELIM

dofile(MODPATH.."nodes.lua")
dofile(MODPATH.."glass.lua")
--dofile(MODPATH.."mapgen.lua")
dofile(MODPATH.."hades.lua")
dofile(MODPATH.."building.lua")
dofile(MODPATH.."furniture.lua")
dofile(MODPATH.."aliases.lua")
dofile(MODPATH.."walls.lua")

dofile(MODPATH.."stairs_functions.lua")
dofile(MODPATH.."stairs.lua")


---------------
-- Crafts Items
---------------
minetest.register_craftitem("hades_darkage:chalk_powder", {
	description = "Chalk Powder",
	inventory_image = "darkage_chalk_powder.png",
})

minetest.register_craftitem("hades_darkage:mud_lump", {
	description = "Mud Lump",
	inventory_image = "darkage_mud_lump.png",
})

minetest.register_craftitem("hades_darkage:silt_lump", {
	description = "Silt Lump",
	inventory_image = "darkage_silt_lump.png",
})

minetest.register_craftitem("hades_darkage:iron_stick", {
	description = "Iron Stick",
	inventory_image = "darkage_iron_stick.png",
})


----------
-- Crafts
----------

--[[
minetest.register_craft({
	output = "hades_darkage:adobe 4",
	recipe = {
		{"hades_default:sand",		"hades_default:sand"},
		{"hades_core:clay_lump",	"hades_farming:straw"},
	}
})
--]]

--[[
	Basalt
]]
minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:basalt",
	recipe = "hades_darkage:basalt_rubble",
})

--[[
minetest.register_craft({
	output = "hades_darkage:basalt_rubble 4",
	recipe = {
		{"hades_core:cobble",		"hades_core:cobble"},
		{"hades_core:coal_lump",	"hades_core:coal_lump"},
	}
})
--]]

minetest.register_craft({
	output = "hades_darkage:basalt_brick 4",
	recipe = {
		{"hades_darkage:basalt", "hades_darkage:basalt", ""},
		{"", "hades_darkage:basalt", "hades_darkage:basalt"},
	}
})

minetest.register_craft({
	output = "hades_darkage:basalt_block 9",
	recipe = {
		{"hades_darkage:basalt", "hades_darkage:basalt", "hades_darkage:basalt"},
		{"hades_darkage:basalt", "hades_darkage:basalt", "hades_darkage:basalt"},
		{"hades_darkage:basalt", "hades_darkage:basalt", "hades_darkage:basalt"},
	}
})

minetest.register_craft({
	output = "hades_darkage:cobble_with_plaster 2",
	recipe = {
		{"hades_core:cobble", "hades_darkage:chalk_powder"},
		{"hades_core:cobble", "hades_darkage:chalk_powder"},
	}
})

minetest.register_craft({
	output = "hades_darkage:cobble_with_plaster 2",
	recipe = {
		{"hades_darkage:chalk_powder", "hades_core:cobble"},
		{"hades_darkage:chalk_powder", "hades_core:cobble"},
	}
})

minetest.register_craft({
	output = "hades_darkage:chalked_bricks_with_plaster 2",
	recipe = {
		{"hades_darkage:chalked_bricks", "hades_darkage:chalk_powder"},
		{"hades_darkage:chalked_bricks", "hades_darkage:chalk_powder"},
	}
})

minetest.register_craft({
	output = "hades_darkage:chalked_bricks_with_plaster 2",
	recipe = {
		{"hades_darkage:chalk_powder", "hades_darkage:chalked_bricks"},
		{"hades_darkage:chalk_powder", "hades_darkage:chalked_bricks"},
	}
})

minetest.register_craft({
	output = "hades_darkage:darkdirt 4",
	recipe = {
		{"hades_core:dirt",	"hades_core:dirt"},
		{"hades_core:gravel",	"hades_core:gravel"},
	}
})

--[[
	Gneiss
]]
--[[
minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:gneiss",
	recipe = "hades_darkage:schist",
})
--]]

minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:gneiss",
	recipe = "hades_darkage:gneiss_rubble",
})

minetest.register_craft({
	output = "hades_darkage:gneiss_brick 4",
	recipe = {
		{"hades_darkage:gneiss", "hades_darkage:gneiss", ""},
		{"", "hades_darkage:gneiss", "hades_darkage:gneiss"},
	}
})

minetest.register_craft({
	output = "hades_darkage:gneiss_block 9",
	recipe = {
		{"hades_darkage:gneiss", "hades_darkage:gneiss", "hades_darkage:gneiss"},
		{"hades_darkage:gneiss", "hades_darkage:gneiss", "hades_darkage:gneiss"},
		{"hades_darkage:gneiss", "hades_darkage:gneiss", "hades_darkage:gneiss"},
	}
})

minetest.register_craft({
	output = "hades_darkage:mud 3",
	recipe = {
		{"hades_core:dirt",		"hades_core:dirt"},
		{"hades_core:clay_lump",	"hades_darkage:silt_lump"},
	}
})

minetest.register_craft({
	output = "hades_darkage:mud",
	recipe = {
		{"hades_darkage:mud_lump", "hades_darkage:mud_lump"},
		{"hades_darkage:mud_lump", "hades_darkage:mud_lump"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:limestone",
	recipe = "hades_darkage:limestone_cobble",
})

minetest.register_craft({
	output = "hades_darkage:limestone_brick 4",
	recipe = {
		{"hades_darkage:limestone", "hades_darkage:limestone", ""},
		{"", "hades_darkage:limestone", "hades_darkage:limestone"},
	}
})

minetest.register_craft({
	output = "hades_darkage:limestone_block 9",
	recipe = {
		{"hades_darkage:limestone", "hades_darkage:limestone", "hades_darkage:limestone"},
		{"hades_darkage:limestone", "hades_darkage:limestone", "hades_darkage:limestone"},
		{"hades_darkage:limestone", "hades_darkage:limestone", "hades_darkage:limestone"},
	}
})

minetest.register_craft({
	output = "hades_darkage:marble_tile 2",
	recipe = {
		{"hades_darkage:marble", "hades_darkage:marble"},
		{"hades_darkage:marble", "hades_darkage:marble"},
	}
})

--[[
	Old Red Sandstone
]]

minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:ors",
	recipe = "hades_darkage:ors_rubble",
})

minetest.register_craft({
	output = "hades_darkage:ors 4",
	recipe = {
		{"hades_core:sandstone", "hades_core:sandstone"},
		{"hades_core:iron_lump", "hades_core:sandstone"},
	}
})
minetest.register_craft({
	output = "hades_darkage:ors_brick 4",
	recipe = {
		{"hades_darkage:ors", "hades_darkage:ors", ""},
		{"", "hades_darkage:ors", "hades_darkage:ors"},
	}
})

minetest.register_craft({
	output = "hades_darkage:ors_block 9",
	recipe = {
		{"hades_darkage:ors", "hades_darkage:ors", "hades_darkage:ors"},
		{"hades_darkage:ors", "hades_darkage:ors", "hades_darkage:ors"},
		{"hades_darkage:ors", "hades_darkage:ors", "hades_darkage:ors"},
	}
})

minetest.register_craft({
	output = "hades_darkage:silt 3",
	recipe = {
		{"hades_core:sand",		"hades_core:sand"},
		{"hades_core:clay_lump",	"hades_core:clay_lump"},
	}
})

minetest.register_craft({
	output = "hades_darkage:silt",
	recipe = {
		{"hades_darkage:silt_lump", "hades_darkage:silt_lump"},
		{"hades_darkage:silt_lump", "hades_darkage:silt_lump"},
	}
})

--[[
	Slate
]]
minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:slate",
	recipe = "hades_darkage:slate_rubble",
})

minetest.register_craft({
	output = "hades_darkage:slate_brick 4",
	recipe = {
		{"hades_darkage:slate", "hades_darkage:slate", ""},
		{"", "hades_darkage:slate", "hades_darkage:slate"},
	}
})

minetest.register_craft({
	output = "hades_darkage:slate_block 9",
	recipe = {
		{"hades_darkage:slate", "hades_darkage:slate", "hades_darkage:slate"},
		{"hades_darkage:slate", "hades_darkage:slate", "hades_darkage:slate"},
		{"hades_darkage:slate", "hades_darkage:slate", "hades_darkage:slate"},
	}
})

minetest.register_craft({
	output = "hades_darkage:slate_tile 2",
	recipe = {
		{"hades_darkage:slate_brick", "hades_darkage:slate_brick"},
		{"hades_darkage:slate_brick", "hades_darkage:slate_brick"},
	}
})

minetest.register_craft({
	output = "hades_darkage:stone_brick 4",
	recipe = {
		{"hades_core:stone_block", "hades_core:stone_block", ""},
		{"", "hades_core:stone_block", "hades_core:stone_block"},
	}
})


minetest.register_craft({
	output = "hades_darkage:straw_bale",
	recipe = {
		{"hades_farming:straw","hades_farming:straw", ""},
		{"hades_farming:straw","hades_farming:straw", "hades_farming:string"},
		{"","hades_farming:string",""}
	}
})

minetest.register_craft({
	output = "hades_darkage:iron_stick 8",
	recipe = {
		{"hades_core:steel_ingot"},
		{"hades_core:steel_ingot"},
	}
})

-- Cookings


minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:dry_leaves",
	recipe = "hades_core:leaves",
})

--[[
minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:schist",
	recipe = "hades_darkage:slate",
})
--]]

--[[
minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:shale",
	recipe = "hades_darkage:mud",
})
--]]

--[[
minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:slate",
	recipe = "hades_darkage:shale",
})
--]]

minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:slate",
	recipe = "hades_darkage:slate_rubble",
})

-- Desert
--[[
minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:ors_brick",
	recipe = "hades_core:stonebrick_baked",
})--]]

-- Tuff
--[[
minetest.register_craft({
	output = "hades_darkage:tuff 2",
	recipe = {
		{"hades_darkage:gneiss", "hades_core:stone"},
		{"hades_core:stone", "hades_darkage:gneiss"},
	}
})
--]]

minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:tuff",
	recipe = "hades_darkage:tuff_rubble",
})

minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:tuff",
	recipe = "hades_darkage:old_tuff_bricks",
})

minetest.register_craft({
	output = "hades_darkage:tuff_bricks 4",
	recipe = {
		{"hades_darkage:tuff", "hades_darkage:tuff", ""},
		{"", "hades_darkage:tuff", "hades_darkage:tuff"},
	}
})

-- Rhyolitic Tuff
--[[
minetest.register_craft({
	output = "hades_darkage:rhyolitic_tuff 2",
	recipe = {
		{"hades_darkage:gneiss", "hades_core:desert_stone"},
		{"hades_core:desert_stone", "hades_darkage:gneiss"},
	}
})
--]]

minetest.register_craft({
	type = "cooking",
	output = "hades_darkage:rhyolitic_tuff",
	recipe = "hades_darkage:rhyolitic_tuff_rubble",
})

minetest.register_craft({
	output = "hades_darkage:rhyolitic_tuff_bricks 4",
	recipe = {
		{"hades_darkage:rhyolitic_tuff", "hades_darkage:rhyolitic_tuff", ""},
		{"", "hades_darkage:rhyolitic_tuff", "hades_darkage:rhyolitic_tuff"},
	}
})
