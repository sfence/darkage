
-- define way how darkage stones etc. hase been created in Hades Revisited world

local S = minetest.get_translator("darkage")

local function add_metamorphosis_report(node_name, report)
  local def = minetest.registered_nodes[node_name]
  if def._metamorphosis_report then
    report = def._metamorphosis_report.."\n\n"..report
  end
  minetest.override_item(node_name, {
      _metamorphosis_report = report
    })
end

function half_time_calc(interval, chance, treshold)
  local steps = math.log(1/(interval+1))/math.log((chance-1)/chance)
  return math.floor(steps*interval/360+0.5)/10
end

local param_treshold = 15

-- rhyolitic tuff
-- from burned tuff
minetest.register_abm({
  label = "Create rhyolitic tuff",
  nodenames = {"hades_core:tuff_baked"},
	neighbors = {"group:water"},
	interval = 337,
	chance = 67,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 1, {"group:lava"}) ~= nil) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:rhyolitic_tuff"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:tuff_baked",
    string.format(S("Burned tuff metamorphoses into burned stone. It requires contact with water and lava. Half-metamorphose time is %i hours."),half_time_calc(337, 67, param_treshold))
  )

add_metamorphosis_report("hades_darkage:rhyolitic_tuff", 
    S("Rhyolitic tuff arise by metamorphosis from burned tuff.")
  )

-- tuff
-- from tuff
minetest.register_abm({
  label = "Create darkage tuff",
  nodenames = {"hades_core:tuff","hades_core:mossytuff"},
	neighbors = {"group:water"},
	interval = 127,
	chance = 29,
  action = function(pos, node)
		node.param1 = node.param1 + 1
		if (node.param1>=param_treshold) then
			minetest.set_node(pos, {name="hades_darkage:tuff"})
		else
			minetest.swap_node(pos, node)
		end
	end,
})

add_metamorphosis_report("hades_core:tuff",
    string.format(S("Tuff metamorphoses into darkage tuff. It requires contact with water. Half-metamorphose time is %i hours."),half_time_calc(127, 29, param_treshold))
  )
add_metamorphosis_report("hades_core:mossytuff",
    string.format(S("Mossy tuff metamorphoses into darkage tuff. It requires contact with water. Half-metamorphose time is %i hours."),half_time_calc(127, 29, param_treshold))
  )

add_metamorphosis_report("hades_darkage:tuff", 
    S("Darkage tuff arise by metamorphosis from tuff or mossy tuff.")
  )

-- schist
-- from sand, clay sediments
-- regional metamorphic
-- higger temp, higger preasure
minetest.register_abm({
  label = "Create schist",
  nodenames = {"hades_core:volcanic_sand", "hades_core:fertile_sand", "hades_core:clay"},
	neighbors = {"group:lava"},
	interval = 503,
	chance = 109,
  action = function(pos, node)
    if (pos.y<-9973) 
				and (minetest.find_node_near(pos, 3, {"air"}) == nil) then
			if (node.name=="hades_core:clay")
					and (minetest.find_node_near(pos, 1, {"group:sand"})~=nil) then
				node.param1 = node.param1 + 1
			elseif (minetest.find_node_near(pos, 1, {"hades_core:clay"})~=nil) then
				node.param1 = node.param1 + 1
			end
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:schist"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:clay",
    string.format(S("Clay metamorphoses into schist in level bellow -9973. It requires contact with lava, sand and air near (up to 3 nodes). Half-metamorphose time is %i hours."),half_time_calc(503, 109, param_treshold))
  )
add_metamorphosis_report("hades_core:volcanic_sand",
    string.format(S("Volcanic sand metamorphoses into schist in level bellow -9973. It requires contact with lava, clay and air near (up to 3 nodes). Half-metamorphose time is %i hours."),half_time_calc(503, 109, param_treshold))
  )
add_metamorphosis_report("hades_core:fertile_sand",
    string.format(S("Volcanic sand metamorphoses into schist in level bellow -9973. It requires contact with lava, clay and air near (up to 3 nodes). Half-metamorphose time is %i hours."),half_time_calc(503, 109, param_treshold))
  )

add_metamorphosis_report("hades_darkage:schist", 
    S("Schist arise by metamorphosis from volcanic/fertile sand and clay.")
  )

-- serpentine
-- from ignerous rock peridotite
-- low temp,oxidation/hydratation
minetest.register_abm({
  label = "Create serpentine",
  nodenames = {"hades_darkage:basalt", "hades_technic:granite"},
	neighbors = {"group:water"},
	interval = 827,
	chance = 61,
  action = function(pos, node)
    if (pos.y>-347) and (minetest.find_node_near(pos, 3, {"air"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:serpentine"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_darkage:basalt",
    string.format(S("Basalt metamorphoses into serpentine in level above -347. It requires contact with water and without air near (up to 3 nodes). Half-metamorphose time is %i hours."),half_time_calc(827, 61, param_treshold))
  )
add_metamorphosis_report("hades_technic:granite",
    string.format(S("Granite metamorphoses into serpentine in level above -347. It requires contact with water and without air near (up to 3 nodes). Half-metamorphose time is %i hours."),half_time_calc(827, 61, param_treshold))
  )

add_metamorphosis_report("hades_darkage:serpentine", 
    S("Serpentine arise by metamorphosis from basalt and granite.")
  )

-- shale
-- forcing clay sediments
minetest.register_abm({
  label = "Create shale",
  nodenames = {"hades_core:clay", "hades_core:volcanic_sand", "group:ash"},
	neighbors = {"group:water"},
	interval = 193,
	chance = 13,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 10, {"hades_core:water_flowing"}) == nil) then
			if (node.name=="hades_core:clay") then
				node.param1 = node.param1 + 1
			elseif (minetest.find_node_near(pos, 1, {"hades_core:clay"})~=nil) then
				node.param1 = node.param1 + 1
			end
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:shale"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:clay",
    string.format(S("Clay metamorphoses into shale. It requires contact with water and no flowing water near (up to 10 nodes). Half-metamorphose time is %i hours."),half_time_calc(193, 13, param_treshold))
  )
add_metamorphosis_report("hades_core:ash",
    string.format(S("Ash metamorphoses into shale. It requires contact with water and no flowing water near (up to 10 nodes). Half-metamorphose time is %i hours."),half_time_calc(193, 13, param_treshold))
  )
add_metamorphosis_report("hades_core:volcanic_sand",
    string.format(S("Volcanic sand metamorphoses into shale. It requires contact with water and no flowing water near (up to 10 nodes). Half-metamorphose time is %i hours."),half_time_calc(193, 13, param_treshold))
  )

add_metamorphosis_report("hades_darkage:shale", 
    S("Shale arise by metamorphosis from clay, volcanic sand and ash.")
  )

-- silt
-- dust sediments
-- water not flowing
minetest.register_abm({
  label = "Create silt",
  nodenames = {"hades_darkage:mud"},
	neighbors = {"hades_core:water"},
	interval = 211,
	chance = 89,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 4, {"hades_core:water_flowing"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:silt"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_darkage:mud",
    string.format(S("Mud metamorphoses into silt. It requires contact with water without flowing water near (up to 4 nodes). Half-metamorphose time is %i hours."),half_time_calc(211, 89, param_treshold))
  )

add_metamorphosis_report("hades_darkage:silt", 
    S("Silt arise by metamorphosis from mud.")
  )

-- slate
-- regional metamorfed shale
-- depth 10 - 25km 200-800 C, 200 - 1500 MPa
minetest.register_abm({
  label = "Create slate",
  nodenames = {"hades_darkage:shale"},
	neighbors = {"group:lava"},
	interval = 1031,
	chance = 211,
  action = function(pos, node)
    if (pos.y<-9973) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:slate"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_darkage:shale",
    string.format(S("Shale metamorphoses into slate in level bellow -9973. It requires contact with lava. Half-metamorphose time is %i hours."),half_time_calc(1031, 211, param_treshold))
  )

add_metamorphosis_report("hades_darkage:slate", 
    S("Slate arise by metamorphosis from shale.")
  )

-- mud
-- dirt under water? Flowing?
minetest.register_abm({
  label = "Create mud",
  nodenames = {"hades_core:dirt"},
	neighbors = {"hades_core:water_flowing"},
	interval = 199,
	chance = 29,
  action = function(pos, node)
    if (minetest.find_node_near(pos, 2, {"air"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:mud"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:dirt",
    string.format(S("Dirt metamorphoses into mud. It requires contact with flowing water without air near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(199, 29, param_treshold))
  )

add_metamorphosis_report("hades_darkage:mud", 
    S("Mud arise by metamorphosis from dirt.")
  )

-- marble?
-- some way to make different marble?
minetest.register_abm({
  label = "Create marble",
  nodenames = {"hades_darkage:limestone"},
	neighbors = {"group:lava"},
	interval = 1031,
	chance = 223,
  action = function(pos, node)
    if (pos.y<-9973) and (minetest.find_node_near(pos, 3, {"air"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:marble"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_darkage:limestone",
    string.format(S("Limestone metamorphoses into darkage marble at level bellow -9973. It requires contact with lava and without air near (up to 3 nodes). Half-metamorphose time is %i hours."),half_time_calc(1031, 223, param_treshold))
  )

add_metamorphosis_report("hades_darkage:marble", 
    S("Darkage marble arise by metamorphosis from limestone.")
  )

-- adobe
-- wind dust combined with seasonal water
minetest.register_abm({
  label = "Create adobe",
  nodenames = {"hades_core:ash", "hades_core:mud", "hades_core:silt"},
	neighbors = {"group:air"},
	interval = 787,
	chance = 503,
  action = function(pos, node)
    if (pos.y<75) then
      return 
    end
    pos.y = pos.y + 1
    local above_node = minetest.get_node(pos)
    if (above_node.name~="air") or ((above_node.param1%16)<15) then
      return
    end
    pos.y = pos.y - 1
    if (node_param1<param_treshold) and (minetest.find_node_near(pos, 4, "group:water")~=nil) then
      return
    end
    
    local pos0 = {x=pos.x-3,y=pos.y-2,z=pos.z-3}
    local pos1 = {x=pos.x+3,y=pos.y+4,z=pos.z+3}
    
    local found_pos = minetest.find_nodes_in_area(pos0, pos1, "air")
    print("air nodes (above creation): "..(#found_pos))
    if #found_pos >= 300 then
			node.param1 = node.param1 + 1
			if (node.param1>param_treshold) then
        if (minetest.find_node_near(pos, 4, "group:water")~=nil) then
				  minetest.set_node(pos, {name="hades_darkage:adobe"})
        end
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_core:ash",
    string.format(S("Ash metamorphoses into adobe at level above 75. It requires contact with surface air above, 300 air nodes or more in area 7x7x7 and without water near in metamorphosing time but with water near in sedimentation time (up to 4 nodes). Half-metamorphose time is %i hours."),half_time_calc(787, 503, param_treshold+1))
  )
add_metamorphosis_report("hades_darkage:mud",
    string.format(S("Mud metamorphoses into adobe at level above 75. It requires contact with surface air above, 300 air nodes or more in area 7x7x7 and without water near in metamorphosing time but with water near in sedimentation time (up to 4 nodes). Half-metamorphose time is %i hours."),half_time_calc(787, 503, param_treshold+1))
  )
add_metamorphosis_report("hades_darkage:silt",
    string.format(S("Silt metamorphoses into adobe at level above 75. It requires contact with surface air above, 300 air nodes or more in area 7x7x7 and without water near in metamorphosing time but with water near in sedimentation time (up to 4 nodes). Half-metamorphose time is %i hours."),half_time_calc(787, 503, param_treshold+1))
  )

add_metamorphosis_report("hades_darkage:adobe", 
    S("Adobe arise by metamorphosis from ash, mud and silt.")
  )

-- chalk
-- from sea microorganishm shells
if minetest.get_modpath("hades_xoceans")~=nil then
	minetest.register_abm({
		label = "Create chalk",
		nodenames = {"group:coral_skeleton"},
		interval = 883,
		chance = 59,
		action = function(pos, node)
			if (minetest.find_node_near(pos, 2, {"air", "group:water", "group:lava"}) == nil) then
				node.param1 = node.param1 + 1
				if (node.param1>=param_treshold) then
					minetest.set_node(pos, {name="hades_darkage:chalk"})
				else
					minetest.swap_node(pos, node)
				end
			end
		end,
  })

  add_metamorphosis_report("hades_xoceans:brain_skeleton",
      string.format(S("Coral skeleton metamorphoses into chalk. It requires NO contact with air near, water near and lava near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(883, 59, param_treshold))
    )
  add_metamorphosis_report("hades_xoceans:tube_skeleton",
      string.format(S("Coral skeleton metamorphoses into chalk. It requires NO contact with air near, water near and lava near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(883, 59, param_treshold))
    )
  add_metamorphosis_report("hades_xoceans:bubble_skeleton",
      string.format(S("Coral skeleton metamorphoses into chalk. It requires NO contact with air near, water near and lava near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(883, 59, param_treshold))
    )
  add_metamorphosis_report("hades_xoceans:coral_skeleton",
      string.format(S("Coral skeleton metamorphoses into chalk. It requires NO contact with air near, water near and lava near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(883, 59, param_treshold))
    )
  add_metamorphosis_report("hades_xoceans:fire_skeleton",
      string.format(S("Coral skeleton metamorphoses into chalk. It requires NO contact with air near, water near and lava near (up to 2 nodes). Half-metamorphose time is %i hours."),half_time_calc(883, 59, param_treshold))
    )

  add_metamorphosis_report("hades_darkage:chalk", 
      S("Chalk arise by metamorphosis from coral skeleton blocks.")
    )
end

-- limestone
-- from chalk
minetest.register_abm({
  label = "Create limestone",
  nodenames = {"hades_darkage:chalk"},
	interval = 1031,
	chance = 199,
  action = function(pos, node)
    if (pos.y<-2111) and (minetest.find_node_near(pos, 5, {"air", "group:water", "group:lava"}) == nil) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:limestone"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_darkage:chalk",
    string.format(S("Chalk metamorphoses into limestone at level bellow -2111. It requires NO contact with lava near, water near and air near (up to 5 nodes). Half-metamorphose time is %i hours."),half_time_calc(1031, 199, param_treshold))
  )

add_metamorphosis_report("hades_darkage:limestone", 
    S("Limestone arise by metamorphosis from chalk.")
  )

-- basalt
-- ignerous rock
-- probably from burned gravel?
minetest.register_abm({
  label = "Create basalt",
  nodenames = {"hades_core:gravel_volcanic"},
	neighbors = {"group:lava"},
	interval = 313,
	chance = 17,
  action = function(pos, node)
		node.param1 = node.param1 + 1
		if (node.param1>=param_treshold) then
			minetest.set_node(pos, {name="hades_darkage:basalt"})
		else
			minetest.swap_node(pos, node)
		end
	end,
})

add_metamorphosis_report("hades_core:gravel_volcanic",
    string.format(S("Volcanic gravel metamorphoses into basalt. It requires contact with lava. Half-metamorphose time is %i hours."),half_time_calc(313, 17, param_treshold))
  )

add_metamorphosis_report("hades_darkage:basalt", 
    S("Basalt arise by metamorphosis from volcanic gravel.")
  )

-- gneiss
-- regional metamorfed
-- high temp, high preasure
-- from igneouus rock or sediments
minetest.register_abm({
  label = "Create gneiss from ignerous rock",
  nodenames = {"hades_darkage:basalt","hades_technic:granite"},
	neighbors = {"group:lava"},
	interval = 1193,
	chance = 37,
  action = function(pos, node)
		if (pos.y<-21067) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:gneiss"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})
minetest.register_abm({
  label = "Create gneiss from sediments",
  nodenames = {"hades_darkage:shale", "hades_darkage:silt", "hades_darkage:mud"},
	neighbors = {"group:lava"},
	interval = 1193,
	chance = 53,
  action = function(pos, node)
		if (pos.y<-21067) then
			node.param1 = node.param1 + 1
			if (node.param1>=param_treshold) then
				minetest.set_node(pos, {name="hades_darkage:gneiss"})
			else
				minetest.swap_node(pos, node)
			end
		end
	end,
})

add_metamorphosis_report("hades_darkage:basalt",
    string.format(S("Basalt metamorphoses into gneiss at level below -21067. It requires contact with lava. Half-metamorphose time is %i hours."),half_time_calc(1193, 37, param_treshold))
  )
add_metamorphosis_report("hades_technic:granite",
    string.format(S("Granite metamorphoses into gneiss at level below -21067. It requires contact with lava. Half-metamorphose time is %i hours."),half_time_calc(1193, 37, param_treshold))
  )

add_metamorphosis_report("hades_darkage:shale",
    string.format(S("Shale metamorphoses into gneiss at level below -21067. It requires contact with lava. Half-metamorphose time is %i hours."),half_time_calc(1193, 53, param_treshold))
  )
add_metamorphosis_report("hades_darkage:silt",
    string.format(S("Silt metamorphoses into gneiss at level below -21067. It requires contact with lava. Half-metamorphose time is %i hours."),half_time_calc(1193, 53, param_treshold))
  )
add_metamorphosis_report("hades_darkage:mud",
    string.format(S("Mud metamorphoses into gneiss at level below -21067. It requires contact with lava. Half-metamorphose time is %i hours."),half_time_calc(1193, 53, param_treshold))
  )

add_metamorphosis_report("hades_darkage:gneiss", 
    S("Gneiss arise by metamorphosis from basalt, granite, shale, silt and mud.")
  )

