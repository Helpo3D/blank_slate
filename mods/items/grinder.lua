--[[
mats
    wood
    metal
    rock
    paper
    cloth
    tech
    colour
]]
core.register_node("bs_items:grinder", {
    description = "Grinder",
    groups={twist=3},
    stack_max = 8,
    sounds = {
    footstep={name = "main_map_tech_soft"},
    dug = {name = "main_map_tech_hard"},
    place={name = "main_map_tech_hard"},
    dig={name = "main_map_tech_break"},
    },
    _blueprint_weight=5,
    _recyle={metal = 10,tech=6},
    tiles = {
        {name="items_grinder_top.png", animation={
            type = "vertical_frames",
            aspect_w = 8,
            aspect_h = 8,
            length = 0.3,
        }}
    ,"items_grinder_bottem.png","items_grinder_side.png"},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        if itemstack:get_definition()._recyle ~= nil then
            local def = itemstack:get_definition()
            local amount = itemstack:get_count()
            for type, quan in pairs(def._recyle) do
                core.add_item({ x = pos.x, y = pos.y + 1, z = pos.z }, "items:" .. type .. " " .. (quan * amount))
            end
            itemstack:take_item(amount)
        end
        return itemstack
    end
})
core.register_craftitem("bs_items:wood", {
    stack_max=1024,
    description = "Wood",
    inventory_image="items_mat_wood.png",
})
core.register_craftitem("bs_items:cloth", {
    stack_max=1024,
    description = "Cloth",
    inventory_image="items_mat_cloth.png",
})
core.register_craftitem("bs_items:metal", {
    stack_max=1024,
    description = "Metal",
    inventory_image="items_mat_metal.png",
})
core.register_craftitem("bs_items:paper", {
    stack_max=1024,
    description = "Paper",
    inventory_image="items_mat_paper.png",
})
core.register_craftitem("bs_items:rock", {
    stack_max=1024,
    description = "rock",
    inventory_image="items_mat_rock.png",
})
core.register_craftitem("bs_items:tech", {
    stack_max=1024,
    description = "Tech",
    inventory_image={name="items_mat_tech.png", animation={
        type = "vertical_frames",
        aspect_w = 8,
        aspect_h = 8,
        length = 3,
    }},
})
core.register_craftitem("bs_items:colour", {
    stack_max=1024,
    description = "Colour essence",
    inventory_image={name="items_mat_colour.png", animation={
        type = "vertical_frames",
        aspect_w = 8,
        aspect_h = 8,
        length = 1,
    }},
})

core.register_on_mods_loaded(function()
    for name, def in pairs(core.registered_items) do
        if def._recyle then
            local textadd = "\n\nwhen scrapped"
            for type, quan in pairs(def._recyle) do
                textadd=textadd..core.colorize(main_map.mat_to_colour[type], "\n"..type.." : "..quan)
            end
            core.override_item(name,{description=def.description..textadd})
        end
    end
end)

core.register_node("bs_items:creationator", {
    description = "Creationator\ntake materiels to build things\nput a blueprint ontop to set recepie",
    groups={twist=3},
    stack_max = 8,
    paramtype2 = "facedir",
    sounds = {
    footstep={name = "main_map_tech_soft"},
    dug = {name = "main_map_tech_hard"},
    place={name = "main_map_tech_hard"},
    dig={name = "main_map_tech_break"},
    },
    _recyle = { metal = 10,tech=5 },
    _blueprint_weight=5,
    tiles = {"items_createonator_top.png","items_createonator_bottem.png","items_createonator_side.png","items_createonator_side.png","items_createonator_side.png","items_createonator.png"},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local node_above = core.get_node({ x = pos.x, y = pos.y + 1, z = pos.z })
        if node_above.name=="bs_items:blueprint" and clicker:is_player()==true then
            local meta=core.get_meta({ x = pos.x, y = pos.y + 1, z = pos.z })
            local item=meta:get_string("blueprint")
            local inv = clicker:get_inventory()
            if item~="" then
                local cando=true
                for type, amount in pairs(main_map.print_recepies[item]) do
                    if not inv:contains_item("main","bs_items:" .. type .. " " .. amount) then
                        cando = false
                    end
                end
                if cando==true then

                    for type, amount in pairs(main_map.print_recepies[item]) do
                        inv:remove_item("main","bs_items:" .. type .. " " .. amount)
                    end
                    core.add_item({ x = pos.x, y = pos.y + 1, z = pos.z }, item)
                    core.sound_play("items_create",{pos=pos,max_hear_distance=7})
                end
            end
        end
        return itemstack
    end
})
local mat_to_seven = {
    wood = 1,
    metal = 2,
    cloth = 3,
    tech = 4,
    paper=5,
    rock =6,
    colour = 7,
}
local auto_creationate=function(pos, listname, index, stack, player)
    local node_above = core.get_node({ x = pos.x, y = pos.y + 1, z = pos.z })
    local inv = core.get_meta(pos):get_inventory()
    if node_above.name == "bs_items:blueprint" then
        local ameta = core.get_meta({ x = pos.x, y = pos.y + 1, z = pos.z })
        if ameta:get_string("blueprint") ~= "" then
            local item = ameta:get_string("blueprint")
            local output=inv:get_stack("main", 8):get_name()
            if output==item or output=="" then
                local max_print = inv:get_stack("main", 8):get_free_space()
                if output=="" then
                    max_print=core.registered_items[item].stack_max
                end
                for type, amount in pairs(main_map.print_recepies[item]) do
                    --cost[type] = amount
                    max_print = math.min(max_print,math.floor(inv:get_stack("main", mat_to_seven[type]):get_count() / amount))
                end

                inv:set_stack("main", 8, item.." "..inv:get_stack("main", 8):get_count()+max_print)
                for type, amount in pairs(main_map.print_recepies[item]) do
                    local stack=inv:get_stack("main", mat_to_seven[type])
                    stack:take_item(max_print*amount)
                    inv:set_stack("main", mat_to_seven[type], stack)
                    if max_print > 0 then
                        core.sound_play("items_create",{pos=pos,max_hear_distance=7})
                    end
                end
            end
        end
    end
end
core.register_node("bs_items:auto_creationator", {
    description = "Auto Creationator\ncreates as many of its blueprint as possible",
    groups={twist=3},
    _blueprint_weight=2,
    sounds = {
    footstep={name = "main_map_tech_soft"},
    dug = {name = "main_map_tech_hard"},
    place={name = "main_map_tech_hard"},
    dig={name = "main_map_tech_break"},
    },
    paramtype2 = "facedir",
    stack_max = 8,
    _recyle={metal = 10,tech=20},
    tiles = {"items_createonator_top.png","items_createonator_bottem.png","items_createonator_side.png","items_createonator_side.png","items_createonator_side.png",
        {name="items_auto_createonator.png", animation={
            type = "vertical_frames",
            aspect_w = 8,
            aspect_h = 8,
            length = 1,
        }}},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        main_map.add_to_clear(pos)
        local node_above = core.get_node({ x = pos.x, y = pos.y + 1, z = pos.z })
        if clicker:is_player() == true then
            local inv = core.get_meta(pos):get_inventory()
            inv:set_size("main", 8)
            local item="bs_items:blueprint"
            local cost={}
            if node_above.name == "bs_items:blueprint" then
                local ameta = core.get_meta({ x = pos.x, y = pos.y + 1, z = pos.z })
                if ameta:get_string("blueprint") ~= "" then
                    item = ameta:get_string("blueprint")
                    for type, amount in pairs(main_map.print_recepies[item]) do
                        cost[type] = amount
                    end
                end
            end
            cost = {
                cost.wood or 0,
                cost.metal or 0,
                cost.cloth or 0,
                cost.tech or 0,
                cost.paper or 0,
                cost.rock or 0,
                cost.colour or 0,
            }
            local formspec=
            "size[8,6]"..
            "list[context;main;0,0;8,1;]" ..
            "item_image[0,1;1,1;bs_items:wood]"..
            "item_image[1,1;1,1;bs_items:metal]"..
            "item_image[2,1;1,1;bs_items:cloth]"..
            "item_image[3,1;1,1;bs_items:tech]"..
            "item_image[4,1;1,1;bs_items:paper]"..
            "item_image[5,1;1,1;bs_items:rock]"..
            "item_image[6,1;1,1;bs_items:colour]"..
            "item_image[7,1;1,1;"..item.."]"
            for i = 1, 7 do
                formspec=formspec.."label["..i-1 ..",1;"..cost[i].."]"
            end
            formspec=formspec.."list[current_player;main;0,2;8,4;]"..
            "listring[context;main]"..
            "listring[current_player;main]"
            core.get_meta(pos):set_string("formspec",formspec)
            --core.show_formspec(clicker:get_player_name(), "items:autoconstuctor", formspec)
        end
    end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
        local meta= core.get_meta(pos)
        local inv = meta:get_inventory()
        local name = stack:get_name()
        if index==1 and name=="bs_items:wood" then
            return 1024-inv:get_stack(listname, index):get_count()
        elseif index==2 and name=="bs_items:metal" then
            return 1024-inv:get_stack(listname, index):get_count()
        elseif index==3 and name=="bs_items:cloth" then
            return 1024-inv:get_stack(listname, index):get_count()
        elseif index==4 and name=="bs_items:tech" then
            return 1024-inv:get_stack(listname, index):get_count()
        elseif index==5 and name=="bs_items:paper" then
            return 1024-inv:get_stack(listname, index):get_count()
        elseif index==6 and name=="bs_items:rock" then
            return 1024-inv:get_stack(listname, index):get_count()
        elseif index==7 and name=="bs_items:colour" then
            return 1024-inv:get_stack(listname, index):get_count()
        end
        return 0
    end,
    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        return 0
    end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
        auto_creationate(pos, listname, index, stack, player)
    end,
    on_destruct = function(pos)
        main_map.dropall(pos)
    end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        auto_creationate(pos, listname, index, stack, player)
    end,
})
