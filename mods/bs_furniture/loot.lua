local toolmult = 0.5
local blockmult = 1
local itemmult=2
local furnmult=1
main_map.loot = {
    { weight = 3,  item = "bs_items:blueprint",    amount = { 1, 8 }, tags = {} },

    {weight=furnmult,item="bs_furniture:chair_1",amount={1,8},tags={block=1,furniture=1,wood=1,fancy=1,big=1}},
    {weight=furnmult,item="bs_furniture:cabinet_1",amount={1,4},tags={block=1,furniture=1,wood=1,fancy=1,big=1}},
    {weight=furnmult,item="bs_furniture:crate_1",amount={1,4},tags={block=1,furniture=1,wood=1,fancy=1,big=1}},

    {weight=blockmult,item="bs_main_map:wall_yellow",amount={1,32},tags={block=1,walls=1,yellow=1,big=1}},
    {weight=blockmult,item="bs_main_map:wall_red",amount={1,32},tags={block=1,walls=1,red=1,big=1}},

    {weight=blockmult,item="bs_main_map:gray_tile",amount={1,32},tags={block=1,roof=1,gray=1,big=1,sterile=1}},
    {weight=blockmult,item="bs_main_map:red_tile",amount={1,32},tags={block=1,walls=1,roof=1,red=1,big=1,rough=1}},
    {weight=blockmult,item="bs_main_map:brown_tile",amount={1,32},tags={block=1,walls=1,floor=1,brown=1,wood=1,big=1}},

    {weight=blockmult,item="bs_main_map:carpet_red",amount={1,32},tags={block=1,floor=1,cloth=1,red=1,big=1,fancy=1}},
    {weight=blockmult,item="bs_main_map:carpet_yellow",amount={1,32},tags={block=1,floor=1,cloth=1,yellow=1,big=1,rough=1}},

    {weight=blockmult,item="bs_main_map:detail_brown",amount={1,32},tags={block=1,wall=1,brown=1,big=1,fancy=1,wood=1}},

    {weight=blockmult,item="bs_main_map:lamp",amount={1,8},tags={block=1,light=1,big=1}},
    {weight=blockmult,item="bs_items:glass",amount={1,32},tags={block=1,fancy=1,big=1}},

    {weight=toolmult,item="bs_items:prybar",amount={1,1},tags={tool=1,rough=1}},
    {weight=toolmult,item="bs_items:mini_hammer",amount={1,1},tags={tool=1,wood=1}},
    {weight=toolmult,item="bs_items:drillbit",amount={1,1},tags={tool=1,rough=1}},
    {weight=toolmult,item="bs_items:ratchet",amount={1,1},tags={tool=1,rough=1}},
    {weight=toolmult/2,item="bs_items:knife",amount={1,1},tags={tool=1,fancy=1}},
    {weight=toolmult,item="bs_items:wrench",amount={1,1},tags={tool=1,rough=1}},
    {weight=toolmult/2,item="bs_items:drill",amount={1,1},tags={tool=1}},
    {weight=toolmult,item="bs_items:miniscrew",amount={1,1},tags={tool=1}},
    {weight=toolmult,item="bs_items:screwdriver",amount={1,1},tags={tool=1}},
    {weight=toolmult,item="bs_items:boxcutter",amount={1,1},tags={tool=1}},

    {weight=itemmult,item="bs_items:cable",amount={1,16},tags={rough=1,small=1}},
    {weight=itemmult,item="bs_items:coin",amount={1,16},tags={fancy=1,small=1}},
    {weight=itemmult,item="bs_items:game_card",amount={1,8},tags={fancy=1,small=1}},
    {weight=itemmult,item="bs_items:paint_bucket",amount={1,8},tags={rough=1,small=1}},
    {weight=itemmult,item="bs_items:pin",amount={1,16},tags={fancy=1,small=1}},
    {weight=itemmult/10,item="bs_items:plush_bird",amount={1,1},tags={fancy=1,small=1}},
    {weight=itemmult/10,item="bs_items:plush_nukie",amount={1,1},tags={fancy=1,small=1}},
    {weight=itemmult/10,item="bs_items:plush_pecho",amount={1,1},tags={fancy=1,small=1}},
    {weight=itemmult/10,item="bs_items:ram",amount={1,1},tags={fancy=1,small=1}},
}
main_map.generate_loot = function(amount, tag_mults)
    local lweight = {}
    local tweight = 0
    local loot={}
    for i = 1, #main_map.loot do
        local myweight = main_map.loot[i].weight
        for tag, amount in pairs(tag_mults) do
            if main_map.loot[i].tags[tag] == 1 then
                myweight = myweight * amount
            end
        end
        if myweight~= 0 then--don't need to worry about blacklisted tags (multiplier of 0)
            table.insert(lweight, { min = tweight, max = tweight + myweight, item = main_map.loot[i].item, amount = main_map.loot[i].amount })
            tweight = tweight + myweight
        end
    end
    if #lweight == 0 then
        return 0
    end
    for i = 1, amount do
        local index = math.random(0, tweight*100)/100
        for a = 1, #lweight do
            if index >= lweight[a].min and index <= lweight[a].max then
                local amount = math.random(lweight[a].amount[1], lweight[a].amount[2])
                if amount == 1 then
                    table.insert(loot, lweight[a].item )
                else
                    table.insert(loot,  lweight[a].item.." "..amount )
                end
                break
            end
        end
    end
    return loot
end


core.register_node("bs_furniture:cabinet_1", {
    description = "Wooden Cabinet",
    groups={pry=3,twist=3},
    _recyle={wood=8,metal=3},
    sunlight_propagates = true,
    drawtype = "mesh",
    mesh="furniture_cabinet_1.obj",
    paramtype2 = "facedir",
    sounds = {
        footstep={name = "main_map_wood"},
        dug = {name = "main_map_wood"},
        place={name = "main_map_wood"},
        dig={name = "main_map_wood"},
    },
    stack_max=8,
    selection_box = {
        type = "fixed",
        fixed = {
            { -3 / 8, -4 / 8, -3 / 8, 3 / 8, 10/8, 3 / 8 },
        }
    },
    collision_box = {
        type = "fixed",
        fixed = {
            { -3 / 8, -4 / 8, -3 / 8, 3 / 8, 10/8, 3 / 8 },
        }
    },
    paramtype = "light",
    tiles = { "furniture_cabinet_1.png" },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        main_map.add_to_clear(pos)
        if inv:get_size("main") == 0 then
            local loot = main_map.generate_loot(math.random(3,10), {furniture=0.5,big=0,wood=1.5,fancy=2,tool=1.5,rough=0.5})
            inv:set_size("main",32)
            meta:set_string("formspec",
                    "size[8,13]"..
                    "list[context;main;2,0;4,8;]"..
                    "list[current_player;main;0,9;8,4;]"..
                    "listring[context;main]"..
                    "listring[current_player;main]"
            )
            for i = 1, #loot do
                inv:set_stack("main", math.random(1, 32), loot[i])
            end
        end
    end,
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main",32)
        meta:set_string("formspec",
                "size[8,13]"..
                "list[context;main;2,0;4,8;]"..
                "list[current_player;main;0,9;8,4;]"..
                "listring[context;main]"..
                "listring[current_player;main]"
        )
    end,
    on_destruct = function(pos)
        main_map.dropall(pos)
    end,
})
core.register_node("bs_furniture:lockbox", {
    description = "Lock Box",
    groups={twist=1,pickup=2},
    _recyle={metal=2, wood=5},
    sunlight_propagates = true,
    sounds = {
        footstep={name = "main_map_wood"},
        dug = {name = "main_map_wood"},
        place={name = "main_map_wood"},
        dig={name = "main_map_wood"},
    },
    drawtype = "nodebox",
    paramtype2 = "facedir",
    stack_max=8,
    node_box = {
        type = "fixed",
        fixed = {
            { -3 / 8, -0.5, -2 / 8, 3 / 8, 0, 2 / 8 },
        }
    },
    paramtype = "light",
    tiles = {"furniture_lockbox_top.png","furniture_lockbox_bottem.png","furniture_lockbox_end.png","furniture_lockbox_end.png","furniture_lockbox_front.png"},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        main_map.add_to_clear(pos)
        if inv:get_size("main") == 0 then
            local loot = main_map.generate_loot(math.random(1,5), {rough=1.5,big=10,wood=1.5,fancy=1.5,tool=1,small=3})
            inv:set_size("main",18)
            meta:set_string("formspec",
                "size[8,9]"..
                "list[context;main;0,0;6,3;]"..
                "list[current_player;main;0,5;8,4;]"..
                "listring[context;main]"..
                "listring[current_player;main]"
            )
            for i = 1, #loot do
                inv:set_stack("main", math.random(1, 32), loot[i])
            end
        end
    end,
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main",18)
        meta:set_string("formspec",
                "size[8,8]"..
                "list[context;main;1,0;6,3;]"..
                "list[current_player;main;0,4;8,4;]"..
                "listring[context;main]"..
                "listring[current_player;main]"
        )
    end,
    on_destruct = function(pos)
        main_map.dropall(pos)
    end,
})
core.register_node("bs_furniture:crate_1", {
    description = "Metal Crate",
    groups={twist=3},
    _recyle={metal=14},
    sunlight_propagates = true,
    drawtype = "mesh",
    mesh="furniture_crate_1.obj",
    paramtype2 = "facedir",
    sounds = {
    footstep={name = "main_map_tech_soft"},
    dug = {name = "main_map_tech_hard"},
    place={name = "main_map_tech_hard"},
    dig={name = "main_map_tech_break"},
    },
    stack_max=8,
    selection_box = {
        type = "fixed",
        fixed = {
            { -7 / 8, -0.499, -0.5, 7 / 8, 2/8, 0.499 },
        }
    },
    collision_box = {
        type = "fixed",
        fixed = {
            { -7 / 8, -0.5, -0.5, 7 / 8, 2/8, 0.5 },
        }
    },
    paramtype = "light",
    tiles = { "furniture_crate_1.png" },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        main_map.add_to_clear(pos)
        if inv:get_size("main") == 0 then
            local loot = main_map.generate_loot(math.random(3,10), {rough=1.5,big=1.5,wood=1.5,fancy=2,tool=1,small=0.75})
            inv:set_size("main",32)
            meta:set_string("formspec",
                "size[8,9]"..
                "list[context;main;0,0;8,4;]"..
                "list[current_player;main;0,5;8,4;]"..
                "listring[context;main]"..
                "listring[current_player;main]"
            )
            for i = 1, #loot do
                inv:set_stack("main", math.random(1, 32), loot[i])
            end
        end
    end,
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        inv:set_size("main",32)
        meta:set_string("formspec",
                "size[8,9]"..
                "list[context;main;0,0;8,4;]"..
                "list[current_player;main;0,5;8,4;]"..
                "listring[context;main]"..
                "listring[current_player;main]"
        )
    end,
    on_destruct = function(pos)
        main_map.dropall(pos)
    end,
})
