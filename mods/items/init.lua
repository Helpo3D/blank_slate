local path = core.get_modpath("bs_items")
dofile(path.."/tools.lua")
dofile(path.."/grinder.lua")
dofile(path.."/blueprints.lua")
dofile(path.."/loot.lua")
core.register_node("bs_items:glass",{
    description = "Glass",
    groups={twist=2,pry=3},
    stack_max=128,
    sunlight_propagates = true,
    _recyle = {rock=7 },
    paramtype = "light",
    drawtype="glasslike_framed_optional",
    tiles = {"items_glass.png","items_clear.png"},
})
