
core.register_node("bs_furniture:television", {
    description = "Television",
    groups={twist=3},
    stack_max = 8,
    light_source=5,
    paramtype2 = "facedir",
    _recyle = { metal = 5,tech=5,rock=5 },
    tiles = {"furniture_tv_top.png","furniture_tv_bottem.png","furniture_tv_side.png","furniture_tv_side.png^[transformFX","furniture_tv_back.png","furniture_tv_front.png"},
})
core.register_node("bs_furniture:fuax_tree", {
    description = "Fuax Tree",
    groups={cut=2,pickup=3,attached_node=1,},
    stack_max = 8,
    walkable = false,
    place_param2 = 2,
    visual_scale = 3.0,
    paramtype = "light",
    sunlight_propagates = true,
    drawtype = "plantlike",
    paramtype2 = "meshoptions",
    _recyle = { wood = 10,paper=5,cloth=5,colour=3 },
    selection_box = {
        type = "fixed",
        fixed = {
            { -2 / 8, -0.5, -2 / 8, 2 / 8, 2, 2 / 8 },
        }
    },
    tiles = {"furniture_faux_tree.png"},
})
core.register_node("bs_furniture:fuax_grass", {
    description = "Fuax Grass",
    groups={cut=2,pickup=3,attached_node=1,},
    stack_max = 8,
    walkable = false,
    paramtype = "light",
    sunlight_propagates = true,
    place_param2 = 3,
    drawtype = "plantlike",
    paramtype2 = "meshoptions",
    _recyle = { wood = 4,paper=5,cloth=5,colour=3 },
    selection_box = {
        type = "fixed",
        fixed = {
            { -3 / 8, -0.5, -3 / 8, 3 / 8, 0, 3 / 8 },
        }
    },
    tiles = {"furniture_faux_grass.png"},
})

core.register_node("bs_furniture:clay_pot", {
    description = "Clay Pot",
    groups={pry=2,twist=2,pickup=3},
    sunlight_propagates = true,
    stack_max=8,
    paramtype = "light",
    _recyle={rock=7, colour=2},
    drawtype = "nodebox",
    node_box = {
        type = "fixed",
        fixed = {
            { -3 / 8, -0.5, -3 / 8, 3 / 8, 0.25, 3 / 8 },
            { -0.5, 0.25, -0.5, 0.5, 0.5, 0.5 },
        }
    },
    tiles = {"furniture_clay_pot_top.png","furniture_clay_pot_bottem.png","furniture_clay_pot_side.png"},
})

core.register_node("bs_furniture:ladder", {
    description = "Ladder",
    groups={pry=2,twist=2,attached_node=1,},
    sunlight_propagates = true,
    stack_max=16,
    climbable = true,
    walkable=false,
    paramtype = "light",
    _recyle = { metal = 7 },
    paramtype2 = "wallmounted",
    drawtype = "signlike",
    selection_box = {type = "wallmounted"},
    tiles = {"furniture_ladder.png"},
})
