local huds={}
core.register_on_joinplayer(function(player)
    core.emerge_area({x=-1,y=-2,z=-1}, {x=1,y=1,z=1})
    core.set_node({x=0,y=-1,z=0},{name="bs_main_map:root"})
    core.after(5,function()core.set_node({x=0,y=-1,z=0},{name="bs_main_map:root"})end)
    core.set_timeofday(0)
    player:hud_set_flags({minimap=false,minimap_radar=false})
    player:override_day_night_ratio(1)
    player:set_sun({
        visible=false,
    })
    player:set_moon({
        visible=false,
    })
    player:set_stars({
        visible=false,
        count=1,
        scale=0.4,
        star_color="#6272c0",
    })
    player:set_clouds({
        density=0,
    })
    player:set_physics_override({speed=1.2,jump=1.4,gravity=1.5})
    player:set_properties({ zoom_fov = 0,
        visual="mesh",
        textures={"player_character.png"},
        mesh = "player_character.obj",
        visual_size={x=5,y=5}
    })
    player:set_sky({
        type = "regular",
        clouds = false,
        sky_color = {
            day_sky = "#ffffff",
            day_horizon = "#9aa6b2",
            dawn_sky = "#ffffff",
            dawn_horizon ="#9aa6b2",
            night_sky = "#ffffff",
            night_horizon = "#9aa6b2",
            indoors = "#9aa6b2",
            fog_sun_tint = "#9aa6b2",
            fog_moon_tint = "#9aa6b2",
            fog_tint_type = "default"
        },
        fog = {
            fog_distance = 100,
            fog_start = 0.2,
        },
    })
    local inv = player:get_inventory()
    inv:set_size("main",32)
    player:set_inventory_formspec("size[8,4]list[context;main;0,0;8,4;]")
    huds[player:get_player_name()]=player:hud_add({
        name = "root_compass",
        hud_elem_type = "image",
        position = { x=0.5, y=0.05 },
        scale = { x = 1, y = 1 },
        text = "player_compass.png",
        size = {x=100, y=50},
    })
end)
core.register_on_dieplayer(function(player, reason)
    local pos=player:get_pos()
    if pos.y<-100 then
        local inv = player:get_inventory()
        local invlist = inv:get_list("main")
        for i=1,#invlist do
            core.add_item({ x = pos.x+math.random(-10,10)/20, y = pos.y + 0.5, z = pos.z+math.random(-10,10)/20 }, invlist[i])
        end
        inv:set_list("main",{})
    end
end)

core.register_chatcommand("unstuck", {
    description = "teleports you to 0,0,0 at the cost hp",
    func = function(name)
        local player = core.get_player_by_name(name)
        player:set_hp(player:get_hp()-10)
        player:set_pos({x=0,y=0,z=0})
    end,
})

core.register_globalstep(function(dtime)
    for index, player in pairs(core.get_connected_players()) do
        local name = player:get_player_name()
        if huds[player:get_player_name()]~= nil then
            local pos = player:get_pos()
            local dir = player:get_look_horizontal() --pi*2
            local yaw = core.dir_to_yaw(pos)
            dir =  (dir-yaw+math.pi*2)%(math.pi*2)-math.pi
            player:hud_change(huds[player:get_player_name()], "position", { x=0.5+dir/3, y=0.05 })
        end
    end
end)
core.register_on_leaveplayer(function(player, timed_out)
    huds[player:get_player_name()]=nil
end)
