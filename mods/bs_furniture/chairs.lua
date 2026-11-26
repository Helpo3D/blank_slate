
core.register_node("bs_furniture:chair_1", {
    description = "Wooden Chair",
    groups={pry=2,twist=2,pickup=3},
    sunlight_propagates = true,
    stack_max=8,
    _recyle={cloth = 2,wood=4,metal=1},
    drawtype = "nodebox",
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -3 / 8, -0.5, -3 / 8, -1 / 8, -1 / 8, -1 / 8 },
            { 3 / 8, -0.5, -3 / 8, 1 / 8, -1 / 8, -1 / 8 },
            { -3 / 8, -0.5, 3 / 8, -1 / 8, -1 / 8, 1 / 8 },
            { 3 / 8,  -0.5, 3 / 8,  1 / 8,  -1 / 8, 1 / 8 },


            { -3 / 8, -1 / 8, -3 / 8, 3 / 8, 0,     3 / 8 },

            { -3 / 8, 0, 2 / 8, 3 / 8, 0.5, 3 / 8 },
        }
    },
    sounds = {
        footstep={name = "main_map_wood"},
        dug = {name = "main_map_wood"},
        place={name = "main_map_wood"},
        dig={name = "main_map_wood"},
    },
    paramtype = "light",
    tiles = {"furniture_char_1_top.png","furniture_char_1_bottem.png","furniture_char_1_front.png"},
})
