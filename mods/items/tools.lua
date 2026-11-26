--groups
-- pry -- wood and simaler materiels
-- 1 furniture
-- 2 bookshelves and doors
-- 3 walls and floors
-- twist -- machines or furniture that can be taken apart
-- 1 tabletop machines
-- 2 drawrs and small machines
-- 3 large things
-- cut -- cloth or wallpaper
-- 1 cardboard
-- 2 curtains
-- 3 wallpaper
-- pickup -- can be broken by hand
-- 1 instant
-- 2 small things
-- 3 decent sized things like chairs
core.override_item("", {
    wield_image="player_hand.png",
    tool_capabilities = {
        full_punch_interval = 1.0,
        max_drop_level = 1,
        groupcaps = {
            pickup = {times = {0, 0.5, 2}, uses = 0, maxlevel = 1},
        },
        damage_groups = {bonk=1},
    },
})
core.register_tool("bs_items:prybar", {
    description = "Prybar",
    _recyle={metal=10},
    _blueprint_weight=0.5,
    _blueprint_cost=2,
    inventory_image="items_prybar.png",
    tool_capabilities = {
        full_punch_interval = 2.0,
        max_drop_level = 1,
        groupcaps = {
            pry = {times = {0.5, 1, 2}, uses = 0, maxlevel = 1},
        },
        damage_groups = {bonk=5},
    },
})
-- core.hypertext_escape(string)
--
core.register_tool("bs_items:crowbar", {
    description = "Crowbar",
    _recyle={metal=10},
    _blueprint_weight=0.5,
    _blueprint_cost = 2,
    _uncraftable=true,
    inventory_image="items_crowbar.png",
    tool_capabilities = {
        full_punch_interval = 0.2,
        max_drop_level = 1,
        groupcaps = {
            pry = {times = {0.5, 1, 0.2}, uses = 0, maxlevel = 1},
            unbreakable = {times = {0.5, 1, 0.2}, uses = 0, maxlevel = 1},
        },
        damage_groups = {bonk=2},
    },
})
core.register_tool("bs_items:mini_hammer", {
    description = "Mini Hammer",
    _recyle={metal=5,wood=5},
    _blueprint_cost=2,
    inventory_image="items_minihammer.png",
    tool_capabilities = {
        full_punch_interval = 1,
        max_drop_level = 1,
        groupcaps = {
            pry = {times = {0.75, 1.5}, uses = 0, maxlevel = 1},
        },
        damage_groups = {bonk=2},
    },
})

core.register_tool("bs_items:drillbit", {
    description = "Drillbit",
    _recyle = { metal = 5},
    _blueprint_weight=0.5,
    _blueprint_cost=2,
    inventory_image="items_tool_drillbit.png",
    tool_capabilities = {
        full_punch_interval = 0.2,
        max_drop_level = 1,
        groupcaps = {
            twist = {times = {1.5, 2}, uses = 0, maxlevel = 1},
        },
        damage_groups = {poke=1},
    },
})
core.register_tool("bs_items:miniscrew", {
    description = "Mini Screwdriver",
    _recyle = { metal = 10, colour = 1 },
    _blueprint_weight=0.5,
    _blueprint_cost=2,
    inventory_image="items_tool_miniscrew.png",
    tool_capabilities = {
        full_punch_interval = 0.4,
        max_drop_level = 1,
        groupcaps = {
            twist = {times = {0.5, 1.25}, uses = 0, maxlevel = 1},
        },
        damage_groups = {poke=2},
    },
})
core.register_tool("bs_items:ratchet", {
    description = "Ratchet",
    _recyle = { metal = 20, colour = 1 },
    _blueprint_weight=0.5,
    _blueprint_cost=2,
    inventory_image="items_tool_ratchet.png",
    tool_capabilities = {
        full_punch_interval = 1,
        max_drop_level = 1,
        groupcaps = {
            twist = {times = {0.6, 1.25, 1.5}, uses = 0, maxlevel = 1},
        },
        damage_groups = {bonk=2},
    },
})
core.register_tool("bs_items:screwdriver", {
    description = "Screwdriver",
    _recyle = { metal = 20, colour = 1 },
    _blueprint_weight=0.5,
    _blueprint_cost=2,
    inventory_image="items_tool_screwdriver.png",
    tool_capabilities = {
        full_punch_interval = 0.4,
        max_drop_level = 1,
        groupcaps = {
            twist = {times = {0.4, 1.25, 1.5}, uses = 0, maxlevel = 1},
        },
        damage_groups = {poke=3},
    },
})
core.register_tool("bs_items:wrench", {
    description = "wrench",
    _recyle = { metal = 20, colour = 1 },
    _blueprint_weight=0.5,
    _blueprint_cost=2,
    inventory_image="items_tool_wrench.png",
    tool_capabilities = {
        full_punch_interval = 0.4,
        max_drop_level = 1,
        groupcaps = {
            twist = {times = {0.5, 1.1, 1.25}, uses = 0, maxlevel = 1},
        },
        damage_groups = {poke=3},
    },
})

core.register_tool("bs_items:drill", {
    description = "Drill",
    _recyle = { metal = 20, tech = 10, colour = 1 },
    _blueprint_weight=0.5,
    _blueprint_cost=2,
    inventory_image={name="items_drill.png", animation={
        type = "vertical_frames",
        aspect_w = 8,
        aspect_h = 8,
        length = 0.5,
    }},
    tool_capabilities = {
        full_punch_interval = 0.4,
        max_drop_level = 1,
        groupcaps = {
            twist = {times = {0.3, 0.75,1}, uses = 0, maxlevel = 1},
        },
        damage_groups = {poke=3},
    },
})

core.register_tool("bs_items:knife", {
    description = "Knife",
    _recyle={metal=10,cloth=5, wood=5},
    _blueprint_cost=2,
    inventory_image="items_tool_knife.png",
    tool_capabilities = {
        full_punch_interval = 0.4,
        max_drop_level = 1,
        groupcaps = {
            cut = {times = {0.3, 0.75}, uses = 0, maxlevel = 1},
        },
        damage_groups = {cut=5},
    },
})
core.register_tool("bs_items:boxcutter", {
    description = "Box Cutter",
    _recyle={metal=10},
    _blueprint_cost=2,
    inventory_image="items_tool_boxcutter.png",
    tool_capabilities = {
        full_punch_interval = 0.4,
        max_drop_level = 1,
        groupcaps = {
            cut = {times = {0.4, 1}, uses = 0, maxlevel = 1},
        },
        damage_groups = {cut=3},
    },
})
core.register_tool("bs_items:survival_axe", {
    description = "Survival Axe",
    _recyle={metal=5,wood=5},
    _blueprint_cost=2,
    inventory_image="items_tool_survival_axe.png",
    tool_capabilities = {
        full_punch_interval = 1,
        max_drop_level = 1,
        groupcaps = {
            pry = {times = {0.75, 1.5}, uses = 0, maxlevel = 1},
            cut = {times = {0.25, 0.5,1.5}, uses = 0, maxlevel = 1},
        },
        damage_groups = {cut=5},
    },
})
