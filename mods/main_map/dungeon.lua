
core.register_node("bs_main_map:red", {
    description = "red",
    groups={unbreakable=1},
    sunlight_propagates = true,
    tiles = {"main_map_slate.png^[colorize:#ff0000"},
})
core.register_node("bs_main_map:blue", {
    description = "blue",
    groups={unbreakable=1},
    sunlight_propagates = true,
    tiles = {"main_map_slate.png^[colorize:#0000ff"},
})
core.register_node("bs_main_map:green", {
    description = "green",
    groups={unbreakable=1},
    sunlight_propagates = true,
    tiles = {"main_map_slate.png^[colorize:#00ff00"},
})

local air = core.get_content_id("air")--empty space
local slate =core.get_content_id("bs_main_map:slate")--rooms
local green =core.get_content_id("bs_main_map:green")--corner walls
local red =core.get_content_id("bs_main_map:red") --walls
local blue =core.get_content_id("bs_main_map:blue") --floors/doors
local clear_rooms = function()
    local maxp = { x = 100, y = -200, z = 100 }
    local minp = { x = -100, y = -220, z = -100 }
    local vm = core.get_voxel_manip()
    local emin, emax = vm:read_from_map(vector.subtract(minp, 3), vector.add(maxp, 3))
    local area = VoxelArea:new { MinEdge = emin, MaxEdge = emax }
    local data = vm:get_data()
    for y = minp.y, maxp.y do
        if y==-218 then
            for x=minp.x,maxp.x do
                for z = minp.z, maxp.z do
                    data[area:index(x, y, z)] = air
                end
            end
        else
            for x=minp.x,maxp.x do
                for z = minp.z, maxp.z do
                    data[area:index(x, y, z)] = slate
                end
            end
        end
    end
    vm:set_data(data)
    vm:write_to_map()
end
local make_rooms = function(type)
    local roomdef=main_map.rooms[type]
    local rooms={}
    local maxp = { x = 100, y = -208, z = 100 }
    local minp = { x = -100, y = -218, z = -100 }
    local vm = core.get_voxel_manip()
    local emin, emax = vm:read_from_map(vector.subtract(minp, 3), vector.add(maxp, 3))
    local area = VoxelArea:new { MinEdge = emin, MaxEdge = emax }
    local data = vm:get_data()
    for i = 2, 80 do       --each ring
        i=80-i
        for a = -i, i-1 do --the z+ side
            local pos = { x = a, y = -218, z = i }
            if data[area:index(pos.x, pos.y, pos.z)] == air then
                local roomsize = { x = math.random(roomdef.min_size, roomdef.max_size), z = math.random(roomdef.min_size,
                    roomdef.max_size) }
                local possible = true
                for b = 1, roomsize.x-1 do
                    if data[area:index(pos.x + b, pos.y, pos.z)] ~= air then
                        possible = false
                    end
                end
                if possible == true then
                    for x = pos.x, pos.x + roomsize.x-1 do
                        for z = pos.z- roomsize.z+1, pos.z do
                            data[area:index(x, pos.y, z)] = slate
                        end
                    end
                    table.insert(rooms, {
                        size = { x = roomsize.x, z = roomsize.z, y = math.random(roomdef.min_hight, roomdef.max_hight) },
                        pos = { x = pos.x, y = pos.y, z = pos.z- roomsize.z+1 } --lowest position
                    })
                end
            end
            --data[area:index(pos.x, pos.y+5, pos.z)] = red
        end
        for a = -i+1, i do --the x+ side
            local pos = { x = i, y = -218, z = a }
            if data[area:index(pos.x, pos.y, pos.z)] == air then
                local roomsize = { x = math.random(roomdef.min_size, roomdef.max_size), z = math.random(roomdef.min_size,
                    roomdef.max_size) }
                local possible = true
                for b = 1, roomsize.z-1 do
                    if data[area:index(pos.x, pos.y, pos.z + b)] ~= air then
                        possible = false
                    end
                end
                if possible == true then
                    for x = pos.x-roomsize.x+1, pos.x do
                        for z = pos.z, pos.z + roomsize.z - 1 do
                            data[area:index(x, pos.y, z)] = slate
                        end
                    end
                    table.insert(rooms, {
                        size = { x = roomsize.x, z = roomsize.z, y = math.random(roomdef.min_hight, roomdef.max_hight) },
                        pos = { x = pos.x-roomsize.x+1, y = pos.y, z = pos.z } --lowest position
                    })
                end
            end
            --data[area:index(pos.x, pos.y+3, pos.z)] = blue
        end
        for a = -i, i-1 do --the z- side
            local pos = { x = -a, y = -218, z = -i }
            if data[area:index(pos.x, pos.y, pos.z)] == air then
                local roomsize = { x = math.random(roomdef.min_size, roomdef.max_size), z = math.random(roomdef.min_size,roomdef.max_size) }
                local possible = true
                for b = 0, roomsize.x-1 do
                    if data[area:index(pos.x - b, pos.y, pos.z)] ~= air then
                        possible = false
                    end
                end
                if possible == true then
                    for x = pos.x-roomsize.x+1, pos.x do
                        for z = pos.z, pos.z+roomsize.z-1 do
                            data[area:index(x, pos.y, z)] = slate
                        end
                    end
                    table.insert(rooms, {
                        size = { x = roomsize.x, z = roomsize.z, y = math.random(roomdef.min_hight, roomdef.max_size) },
                        pos = { x = pos.x-roomsize.x+1, y = pos.y, z = pos.z } --lowest position
                    })
                end
            end
            --data[area:index(pos.x, pos.y+5, pos.z)] = red
        end
        for a = -i+1,i do--the x+ side
            local pos = { x = -i, y = -218, z = -a }
            if data[area:index(pos.x, pos.y, pos.z)] == air then
                local roomsize = {x=math.random(roomdef.min_size, roomdef.max_size),z=math.random(roomdef.min_size, roomdef.max_size)}
                local possible = true
                for b = 0, roomsize.z-1 do
                    if data[area:index(pos.x, pos.y, pos.z- b)] ~= air then
                        possible = false
                    end
                end
                if possible == true then
                    for x = pos.x, pos.x+roomsize.x-1 do
                        for z = pos.z-roomsize.z+1, pos.z do
                            data[area:index(x, pos.y, z)] = slate
                        end
                    end
                    table.insert(rooms, {
                        size = { x = roomsize.x, z = roomsize.z, y = math.random(roomdef.min_hight, roomdef.max_size) },
                        pos = {x=pos.x,y=pos.y,z=pos.z-roomsize.z+1}--lowest position
                    })
                end
            end
            --data[area:index(pos.x, pos.y+2, pos.z)] = blue
        end
    end
    vm:set_data(data)
    vm:write_to_map()
    return rooms
end

local layout_rooms = function(rooms,type)
    local roomdef=main_map.rooms[type]
    local maxp = { x = 100, y = -208, z = 100 }
    local minp = { x = -100, y = -218, z = -100 }
    local vm = core.get_voxel_manip()
    local emin, emax = vm:read_from_map(vector.subtract(minp, 3), vector.add(maxp, 3))
    local area = VoxelArea:new { MinEdge = emin, MaxEdge = emax }
    local data = vm:get_data()
    for i = 1, #rooms do
        local room = rooms[i]
        for x = 1,room.size.x-2 do
            data[area:index(room.pos.x+x, -218, room.pos.z)] = red
            data[area:index(room.pos.x+x, -218, room.pos.z+room.size.z-1)] = red
        end
        for z = 1, room.size.z - 2 do
            data[area:index(room.pos.x, -218, room.pos.z + z)] = red
            data[area:index(room.pos.x + room.size.x - 1, -218, room.pos.z + z)] = red
        end
        data[area:index(room.pos.x, -218, room.pos.z)] = green
        data[area:index(room.pos.x, -218, room.pos.z+room.size.z-1)] = green
        data[area:index(room.pos.x+room.size.x-1, -218, room.pos.z)] = green
        data[area:index(room.pos.x + room.size.x - 1, -218, room.pos.z + room.size.z - 1)] = green
    end
    for i = 1, #rooms do
        local room = rooms[i]
        for x = 1, room.size.x - 2 do
            if data[area:index(room.pos.x+x, -218, room.pos.z-1)]==red or data[area:index(room.pos.x+x, -217, room.pos.z-1)] == blue then
                data[area:index(room.pos.x+x, -218, room.pos.z-1)] = blue
            end
            if data[area:index(room.pos.x+x, -218, room.pos.z+room.size.z)]==red or data[area:index(room.pos.x+x, -217, room.pos.z+room.size.z)] == blue then
                data[area:index(room.pos.x+x, -218, room.pos.z+room.size.z)] = blue
            end
        end
        for z = 1, room.size.z - 2 do
            if data[area:index(room.pos.x-1, -218, room.pos.z + z)] == red or data[area:index(room.pos.x-1, -217, room.pos.z + z)] == blue then
                data[area:index(room.pos.x-1, -218, room.pos.z + z)] = blue
            end
            if data[area:index(room.pos.x + room.size.x, -218, room.pos.z + z)] == red or data[area:index(room.pos.x + room.size.x, -217, room.pos.z + z)] == blue then
                data[area:index(room.pos.x + room.size.x, -218, room.pos.z + z)] = blue
            end
        end
    end
    vm:set_data(data)
    vm:write_to_map()
end
local deco_rooms = function(rooms,type)
    local roomdef=main_map.rooms[type]
    local maxp = { x = 100, y = -200, z = 100 }
    local minp = { x = -100, y = -218, z = -100 }
    local vm = core.get_voxel_manip()
    local emin, emax = vm:read_from_map(vector.subtract(minp, 3), vector.add(maxp, 3))
    local area = VoxelArea:new { MinEdge = emin, MaxEdge = emax }
    local data = vm:get_data()
    for i = 1, #rooms do
        local room = rooms[i]
        for x = 0, room.size.x - 1 do
            for z = 0, room.size.z - 1 do
                for y = room.size.y, roomdef.max_hight do
                    data[area:index(room.pos.x + x, -217 + y, room.pos.z + z)] = roomdef.above
                end
                if data[area:index(room.pos.x+x, -218, room.pos.z+z)] == green then
                    data[area:index(room.pos.x+x, -218, room.pos.z+z)] = red
                end
                if data[area:index(room.pos.x+x, -218, room.pos.z+z)] == red then
                    for y = 1, room.size.y do
                        if y>#roomdef.walls then
                            data[area:index(room.pos.x + x, -218 + y, room.pos.z+z)] = roomdef.walls[#roomdef.walls]
                        else
                            data[area:index(room.pos.x + x, -218 + y, room.pos.z+z)] = roomdef.walls[y]
                        end
                    end
                else
                    for y = 1, room.size.y-1 do
                        data[area:index(room.pos.x + x, -217 + y, room.pos.z+z)] = air
                    end
                    data[area:index(room.pos.x + x, -217, room.pos.z + z)] = roomdef.floor
                    if (room.pos.x+x)%5==0 and  (room.pos.z+z)%5==0 then
                        data[area:index(room.pos.x+x, -217+room.size.y, room.pos.z + z)] = roomdef.light
                    else
                        data[area:index(room.pos.x+x, -217+room.size.y, room.pos.z + z)] = roomdef.ceiling
                    end
                end
            end
        end
    end
    vm:set_data(data)
    vm:write_to_map()
end
local generate_furniture = function(rooms, type)
    local roomdef = main_map.rooms[type]
    local maxp = { x = 100, y = -200, z = 100 }
    local minp = { x = -100, y = -218, z = -100 }
    local vm = core.get_voxel_manip()
    local shcems = {}
    local emin, emax = vm:read_from_map(minp, maxp)
    local area = VoxelArea:new { MinEdge = emin, MaxEdge = emax }
    local data = vm:get_data()
    for i = 1, #rooms do
        local room = rooms[i]
        local decors = math.floor(math.abs(room.size.x * room.size.y) ^ (1 / 3))
        for a = 1, decors do
            local decpos = {
                x = room.pos.x + math.random(1, room.size.x - 2),
                y = -216,
                z = room.pos.z +
                    math.random(1, room.size.z - 2)
            }
            local deco = main_map.decos[math.random(1, #main_map.decos)]
            local decosize = { x = deco.size[1] - 1, y = deco.size[2], z = deco.size[3] - 1 }
            local dir = math.random(0, 3)
            if dir == 1 or dir == 3 then
                decosize = { x = deco.size[3] - 1, y = deco.size[2], z = deco.size[1] - 1 }
            end
            if deco.size[2] <= room.size.y then
                local cangen = true
                for x = math.min(0, decosize.x), math.max(0, decosize.x) do
                    for z = math.min(0, decosize.z), math.max(0, decosize.z) do
                        if data[area:index(decpos.x + x, -218, decpos.z + z)] == red then
                            cangen = false
                        end
                    end
                end
                if cangen == true then
                    for x = math.min(0, decosize.x), math.max(0, decosize.x) do
                        for z = math.min(0, decosize.z), math.max(0, decosize.z) do
                            data[area:index(decpos.x + x, -218, decpos.z + z)] = red
                            --data[area:index(decpos.x + x, -217, decpos.z + z)] = red
                        end
                    end
                    if deco.offset~=nil then
                        decpos=vector.add(decpos,deco.offset)
                    end
                    --data[area:index(decpos.x, -215, decpos.z)] = red
                    table.insert(shcems, { decpos, deco.schem, dir * 90 + deco.rotation })
                end
            end
        end
    end
    vm:set_data(data)
    for i = 1, #shcems do
        core.place_schematic_on_vmanip(vm, shcems[i][1], shcems[i][2], shcems[i][3] % 360, nil, true)
    end
    vm:write_to_map()
end
local valid_rooms = {
    "back","hotel","old"
}
main_map.generate_dungeon = function()
    for index, player in pairs(core.get_connected_players()) do
        if player:get_pos().y < -100 then
            --local inv = player:get_inventory()
            --inv:set_list("main",{})
            player:set_hp(0)
            player:set_pos({ x = 0, y = 0, z = 0 })
            player:set_hp(20)
        end
    end
    for pos, thing in pairs(main_map.to_clear) do
        local meta = core.get_meta(pos)
        meta:from_table({})
    end
    clear_rooms()
    local type = valid_rooms[math.random(1, #valid_rooms)]
    local rooms = make_rooms(type)
    layout_rooms(rooms, type)
    deco_rooms(rooms, type)
    generate_furniture(rooms, type)
    core.chat_send_all("The dungeon has reset")
    core.place_schematic({ x = -5, y = -217, z = -5 }, core.get_modpath("bs_main_map") .. "/schems/dungeon_exit.mts", 0,
        nil, true)
end
--[[
core.register_chatcommand("dun", {
    description = "lag?",
    func = function(name)
        core.chat_send_all("The dungeon is now reseting")
        main_map.generate_dungeon()
    end,
    })
]]
