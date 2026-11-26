local blueprints = {
}
main_map.print_recepies = {
}
local total_blue_weight=0
core.register_node("bs_items:blueprint", {
    description = "Unkown blueprint\nplace to determine",
    groups={pickup=1,attached_node=1},
    sunlight_propagates = true,
    _uncraftable=true,
    stack_max=8,
    _recyle={paper = 3},
    drawtype = "nodebox",
    sounds = {
        footstep={name = "items_paper_step"},
        dug = {name = "items_paper"},
        place={name = "items_paper"},
        dig={name = "items_paper"},
    },
    paramtype2 = "facedir",
    node_box = {
        type = "fixed",
        fixed = {
            { -3 / 8, -0.5, -3 / 8, 3 / 8, -0.499, 3 / 8 },
            { -0.5, -0.5, -0.5, -2/8, -2/8, 0.5 },
            { 0.5, -0.5, -0.5, 2/8, -2/8, 0.5 },
        }
    },
    paramtype = "light",
    tiles = {"items_blueprint_top.png","items_blueprint_top.png","items_blueprint_side.png","items_blueprint_side.png","items_blueprint_end.png",},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta=core.get_meta(pos)
        if meta:get_string("blueprint") ~= "" then
            local item = core.add_entity(pos, "bs_items:blue_preview")
            item:set_properties({wield_item=meta:get_string("blueprint")})
        end

    end,
    preserve_metadata = function(pos, oldnode, oldmeta, drops)
        local item = drops[1]
        local meta = drops[1]:get_meta()
        if oldmeta.blueprint ~= nil then
            meta:set_string("description", oldmeta.description)
            meta:set_string("infotext", oldmeta.infotext)
            meta:set_string("blueprint", oldmeta.blueprint)
            local texture = core.registered_items[oldmeta.blueprint].inventory_image
            if core.registered_items[oldmeta.blueprint].tiles then
                texture = core.registered_items[oldmeta.blueprint].tiles
            end
            if type(texture) == "table" then
                if type(texture[1]) == "table" then
                    texture[1] = texture[2]
                end
                if type(texture[1])=="string" then
                texture="([inventorycube{"..texture[1].."{"..texture[(2%#texture)+1].."{"..texture[(3%#texture)+1].."\\^[resize\\:16x16)"
                else
                    texture="items_clear.png"
                end
            end
            texture="[combine:32x32:16,16="..texture
            meta:set_string("inventory_overlay", texture)
        end
    end,
    after_place_node = function(pos, placer, itemstack, pointed_thing)
        main_map.add_to_clear(pos)
        local meta = itemstack:get_meta()
        local newmeta=core.get_meta(pos)
        newmeta:set_string("description",meta:get_string("description"))
        newmeta:set_string("infotext", meta:get_string("infotext"))
        newmeta:set_string("blueprint", meta:get_string("blueprint"))
        if newmeta:get_string("blueprint") == "" then
            local bluerandom = math.random(1, total_blue_weight*100)/100
            local selected = 0
            for i = 1,#blueprints do
                if bluerandom >= blueprints[i].min and bluerandom <= blueprints[i].max then
                    selected=i
                    break
                end
            end
            newmeta:set_string("blueprint", blueprints[selected].item)
            local info = "makes : " ..
            string.split(core.registered_items[blueprints[selected].item].description, "\n")[1] .. "\ncosts : "
            for type, amount in pairs(main_map.print_recepies[blueprints[selected].item]) do
                info=info..core.colorize(main_map.mat_to_colour[type],"\n"..type.." : "..amount)
            end
            newmeta:set_string("infotext",info)
            newmeta:set_string("description","Blueprint\n"..info)
        end
    end
})

core.register_on_mods_loaded(function()
    for name, def in pairs(core.registered_items) do
        if def._recyle and def._uncraftable~=true then
            local bluedef = {
                weight = def._blueprint_weight or 1,
                item = name,
            }
            local cost = {}
            local mult = def._blueprint_cost or 1.5
            for type, amount in pairs(def._recyle) do
                cost[type] = math.floor(amount * mult)
            end
            table.insert(blueprints, bluedef)
            main_map.print_recepies[name] = cost
        end
    end
    for i = 1, #blueprints do
        blueprints[i].min=total_blue_weight
        total_blue_weight=total_blue_weight+blueprints[i].weight
        blueprints[i].max=total_blue_weight
    end
end)

core.register_entity("bs_items:blue_preview",{
    initial_properties={
        hp_max = 1,
        selectionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
        collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
        visual = "wielditem",
        wield_item = "bs_items:blueprint",
        visual_size={x=0.3,y=0.3},
        physical = false,
        automatic_rotate=1,
        collide_with_objects=false,
        pointable=true,
    },
	_timer=0,
    on_step = function(self, dtime)
        self._timer = self._timer + dtime
        if self._timer>5 then
            self.object:remove()
        end
	end
})
