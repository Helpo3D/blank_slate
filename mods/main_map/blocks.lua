main_map.afterdig=function(pos, oldnode, oldmetadata, digger)
    if pos.y<-100 then
        --core.set_node(pos,{name="main_map:slate"})
    end
end

core.register_node("bs_main_map:wall_yellow", {
    description = "Yellow Wall",
    groups = { pry = 3,cut=3 },
    _recyle={wood=5,paper=3,colour=1},
    stack_max=128,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_yellow_wall.png"},
    sounds = {
        footstep={name = "main_map_wood"},
        dug = {name = "main_map_wood"},
        place={name = "main_map_wood"},
        dig={name = "main_map_wood"},
    },
})
core.register_node("bs_main_map:wall_red", {
    description = "Red Wall",
    _recyle={wood=5,paper=3,colour=1},
    groups = { pry = 3,cut=3 },
    stack_max=128,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_red_wall.png"},
    sounds = {
        footstep={name = "main_map_wood"},
        dug = {name = "main_map_wood"},
        place={name = "main_map_wood"},
        dig={name = "main_map_wood"},
    },
})

core.register_node("bs_main_map:gray_tile", {
    description = "Gray Tiles",
    _recyle={wood=3,paper=5,colour=1},
    groups={pry=2},
    stack_max=128,
    sounds = {
        footstep={name = "main_map_hard_soft"},
        dug = {name = "main_map_hard_loud"},
        place={name = "main_map_hard_loud"},
        dig={name = "main_map_hard_soft"},
    },
    after_dig_node =main_map.afterdig,
    tiles = {{
           name = "main_map_grey_tile.png",
           align_style = 'world',
           scale = 2
       }},
})
core.register_node("bs_main_map:red_tile", {
    description = "Red Tiles",
    groups={pry=3},
    _recyle={colour=1,rock=7},
    sounds = {
        footstep={name = "main_map_hard_soft"},
        dug = {name = "main_map_hard_loud"},
        place={name = "main_map_hard_loud"},
        dig={name = "main_map_hard_soft"},
    },
    stack_max=128,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_red_tile.png"},
})
core.register_node("bs_main_map:brown_tile", {
    description = "Brown Tiles",
    groups={pry=3},
    _recyle={wood=8,colour=1},
    stack_max=128,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_brown_tile.png"},
    sounds = {
        footstep={name = "main_map_wood"},
        dug = {name = "main_map_wood"},
        place={name = "main_map_wood"},
        dig={name = "main_map_wood"},
    },
})

core.register_node("bs_main_map:carpet_red", {
    description = "Red Carpet",
    groups={pry=3,cut=3},
    _recyle={wood=3,cloth=5,colour=1},
    stack_max=128,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_red_carpet.png"},
})
core.register_node("bs_main_map:carpet_yellow", {
    description = "Yellow Carpet",
    groups={pry=3,cut=3},
    _recyle={wood=3,cloth=5,colour=1},
    stack_max=128,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_yellow_carpet.png"},
})

core.register_node("bs_main_map:detail_brown", {
    description = "Brown Trim",
    groups={pry=3},
    _recyle={wood=8,colour=1},
    stack_max=128,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_brown_detail.png"},
    sounds = {
        footstep={name = "main_map_wood"},
        dug = {name = "main_map_wood"},
        place={name = "main_map_wood"},
        dig={name = "main_map_wood"},
    },
})

core.register_node("bs_main_map:lamp", {
    description = "lamp",
    groups={pry=3,twist=3},
    stack_max=32,
    _recyle={metal=8,tech=4},
    sunlight_propagates = false,
    light_source=14,
    after_dig_node =main_map.afterdig,
    tiles = {"main_map_light_top.png","main_map_light_bottem.png","main_map_light_side.png"},
})
