local path = core.get_modpath("bs_main_map")
local storage = core.get_mod_storage()
local regen_time = storage:get_int("bs_main_map:reset")
local firstime = storage:get_int("bs_main_map:first")
local regen_short_time=59
main_map = {
    to_clear = {},
    add_to_clear = function(pos)
        if pos.y<-100 then
            main_map.to_clear[pos]=true
        end
    end,
    mat_to_colour = {
        wood="#c1691e",
        metal="#555555",
        cloth="#e4e0bb",
        tech="#567a3a",
        paper="#e2e2e2",
        rock="#7a7a7a",
        colour="#e111cb",
    },
    rooms = {
    },
    dropall = function(pos)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        for i = 1,inv:get_size("main") do
            core.add_item({ x = pos.x, y = pos.y, z = pos.z }, inv:get_stack("main", i))
        end
    end,
    max_stack = 128,
}
dofile(path .. "/blocks.lua")
dofile(path .. "/alieses_cause_contdb_requrements_are_dumb.lua")
main_map.decos = {
    {
        size = { 2, 1, 1 },
        schem = path .. "/schems/dungeon_chair_1.mts",
        rotation = -90,
    },
    {
        size = { 4, 4, 3 },
        schem = path .. "/schems/dungeon_fireplace_1.mts",
        rotation = -90,
    },
    {
        size = { 1, 4, 1 },
        schem = path .. "/schems/dungeon_pillar_1.mts",
        rotation = -90,
    },
    {
        size = { 1, 6, 1 },
        schem = path .. "/schems/dungeon_pillar_2.mts",
        rotation = -90,
    },
    {
        size = { 3, 6, 1 },
        schem = path .. "/schems/dungeon_pillar_3.mts",
        rotation = -90,
    },
    {
        size = { 2, 1, 1 },
        schem = path .. "/schems/dungeon_scrapper_1.mts",
        rotation = -90,
    },
    {
        size = { 2, 1, 1 },
        schem = path .. "/schems/dungeon_constructor_1.mts",
        rotation = -90,
    },
    {
        size = { 3, 2, 1 },
        schem = path .. "/schems/dungeon_table_1.mts",
        rotation = -90,
    },
    {
        size = { 3, 2, 3 },
        schem = path .. "/schems/dungeon_tv_1.mts",
        rotation = -90,
    },
    {
        size = { 5, 2, 5 },
        schem = path .. "/schems/dungeon_forest_1.mts",
        rotation = -90,
        offset={x=0,y=-1,z=0}
    },
    {
        size = { 1, 1, 1 },
        schem = path .. "/schems/dungeon_pot_1.mts",
        rotation = -90,
    },
    {
        size = { 1, 1, 1 },
        schem = path .. "/schems/dungeon_grass_1.mts",
        rotation = -90,
    },
    {
        size = { 3, 2, 2 },
        schem = path .. "/schems/dungeon_crate_1.mts",
        rotation = -90,
    },
    {
        size = { 2, 2, 1 },
        schem = path .. "/schems/dungeon_closet_1.mts",
        rotation = -90,
    },
}
main_map.rooms.back = {
    max_size = 10,
    min_size = 5,
    max_hight=10,
    min_hight = 4,
    ceiling=core.get_content_id("bs_main_map:gray_tile"),
    floor=core.get_content_id("bs_main_map:carpet_yellow"),
    walls={core.get_content_id("bs_main_map:wall_yellow")},
    light=core.get_content_id("bs_main_map:lamp"),
    above=core.get_content_id("bs_main_map:wall_yellow"),
}
main_map.rooms.hotel = {
    max_size = 10,
    min_size = 5,
    max_hight=10,
    min_hight = 4,
    ceiling=core.get_content_id("bs_main_map:brown_tile"),
    floor=core.get_content_id("bs_main_map:carpet_red"),
    walls={core.get_content_id("bs_main_map:detail_brown"),core.get_content_id("bs_main_map:detail_brown"),core.get_content_id("bs_main_map:wall_red")},
    light=core.get_content_id("bs_main_map:lamp"),
    above=core.get_content_id("bs_main_map:brown_tile"),
}
main_map.rooms.old = {
    max_size = 10,
    min_size = 5,
    max_hight=10,
    min_hight = 4,
    ceiling=core.get_content_id("bs_main_map:red_tile"),
    floor=core.get_content_id("bs_main_map:brown_tile"),
    walls={core.get_content_id("bs_main_map:red_tile")},
    light=core.get_content_id("bs_main_map:lamp"),
    above=core.get_content_id("bs_main_map:red_tile"),
}
core.register_node("bs_main_map:slate", {
    description = "Slate",
    groups={unbreakable=1},
    sunlight_propagates = true,
    tiles = {"main_map_slate.png"},
})
core.register_node("bs_main_map:root", {
    description = "Root",
    light_source = 14,
    sunlight_propagates = true,
    groups={unbreakable=1},
    tiles = {"main_map_root_top.png","main_map_root_side.png"},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local num = (math.random(0, 1) * 2) - 1
        local pos = { x = num, y = -215, z = -num }
        if num == math.random(0, 1) then
            pos.x=74*num
            pos.z=(math.random(0, 1) * 148) - 74
        else
            pos.z=74*num
            pos.x=(math.random(0, 1) * 148) - 74
        end
        core.emerge_area({ x = pos.x - 1, y = pos.y - 1, z = pos.z - 1 }, { x = pos.x + 1, y = pos.y + 1, z = pos.z + 1 })
        if core.get_node(pos).name ~= "ignore" then
            clicker:set_pos(pos)
            core.chat_send_player(clicker:get_player_name(),"welcome to the dungeon. find loot and steal everything")
            core.chat_send_player(clicker:get_player_name(),"make it to 0,0 before time runs out")
            core.chat_send_player(clicker:get_player_name(),"use materiels from the dungeon to fill the void")
            core.chat_send_player(clicker:get_player_name(),"if you are trapped use /unstuck to return to 0,0,0 at the cost of half your health")
        else
            core.chat_send_player(clicker:get_player_name(),core.colorize("#f81212","teleport failed. please try again"))
        end
    end
})
core.register_node("bs_main_map:exit", {
    description = "exit",
    light_source = 14,
    sunlight_propagates = true,
    groups={unbreakable=1},
    tiles = {"main_map_exit_top.png","main_map_exit_side.png"},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        clicker:set_pos({x=0,y=0,z=0})
        clicker:set_hp(20)
        core.chat_send_player(clicker:get_player_name(),"you have successfully escaped the dungeon")
        core.chat_send_player(clicker:get_player_name(),"scrap things and use creationators and blueprints to make things")
        core.chat_send_player(clicker:get_player_name(),"fill the endless(very large) void")
    end
})
dofile(path.."/alieses_cause_contdb_requrements_are_dumb.lua")
dofile(path.."/dungeon.lua")
slateindex= core.get_content_id("bs_main_map:slate")
core.register_on_generated(function(minp, maxp, blockseed)
    local vm, emin, emax = core.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new({MinEdge=emin, MaxEdge=emax})
    local data = vm:get_data()
        for y = minp.y, maxp.y do
            if y < -1 and y>-150 then
                for x= minp.x,maxp.x do
                    for z = minp.z, maxp.z do
                        data[area:index(x, y, z)]=slateindex
                    end
                end
            end
        end
    vm:set_data(data)
    vm:write_to_map()
end)

local total_time = 10
core.register_globalstep(function(dtime)
    regen_short_time = regen_short_time + dtime
    if regen_short_time> 60 then
        regen_short_time = regen_short_time - 60
        regen_time = regen_time + 1
        if regen_time==total_time-5 then
            core.chat_send_all(core.colorize("#f81212","five minutes remain before the dungeon resets"))
            for index, player in pairs(core.get_connected_players()) do
                if player:get_pos().y<-100 then
                    core.chat_send_player(player:get_player_name(),core.colorize("#f81212","PROCEED TO 0,0 to extract"))
                end
            end
        elseif regen_time==total_time-1 then
            core.chat_send_all(core.colorize("#f81212","one minute remains before the dungeon resets"))
            for index, player in pairs(core.get_connected_players()) do
                if player:get_pos().y<-100 then
                    core.chat_send_player(player:get_player_name(),core.colorize("#f81212","PROCEED TO 0,0 to extract, faliure to do so will result in death"))
                end
            end
        end
        if regen_time >= total_time or firstime==0 then
            core.set_node({x=0,y=-1,z=0},{name="bs_main_map:root"})
            storage:set_int("bs_main_map:first", 1)
            firstime=1
            main_map.generate_dungeon()
            regen_time=0
        end
        storage:set_int("bs_main_map:reset", regen_time)
    end
end)
