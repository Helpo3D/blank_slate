
core.register_craftitem("bs_items:cable", {
    description = "Cable Coil",
    stack_max=64,
    _recyle={metal=5,paper=5},
    _uncraftable=true,
    inventory_image="items_cable.png",
})
core.register_craftitem("bs_items:coin", {
    description = "Old Coin",
    stack_max=128,
    _recyle={metal=4},
    _uncraftable=true,
    inventory_image="items_coin.png",
})
core.register_craftitem("bs_items:game_card", {
    description = "Game Card",
    stack_max=32,
    _recyle={metal=4,tech=5,colour=5},
    _uncraftable=true,
    inventory_image="items_game_card.png",
})
core.register_craftitem("bs_items:paint_bucket", {
    description = "Paint Bucket",
    stack_max=32,
    _recyle={metal=4,colour=10},
    _uncraftable=true,
    inventory_image="items_paint_bucket.png",
})
core.register_craftitem("bs_items:pin", {
    description = "Sewing pin",
    stack_max=128,
    _recyle={metal=3,colour=1},
    _uncraftable=true,
    inventory_image="items_pin.png",
})
core.register_craftitem("bs_items:plush_bird", {
    description = "Bird Plushie\nIts eyes can see very far",
    stack_max=8,
    _recyle={cloth=20,colour=3,metal=1},
    _uncraftable=true,
    inventory_image="items_plush_bird.png",
})
core.register_craftitem("bs_items:plush_nukie", {
    description = "Nukie Plushie\n;REAL?!",
    stack_max=8,
    _recyle={cloth=20,colour=3},
    _uncraftable=true,
    inventory_image="items_plush_nukie.png",
})
core.register_craftitem("bs_items:plush_pecho", {
    description = "Pecho Plushie",
    stack_max=8,
    _recyle={cloth=20,colour=3},
    _uncraftable=true,
    inventory_image="items_plush_pecho.png",
})
core.register_craftitem("bs_items:ram", {
    description = "Ram\nA fictional resource",
    stack_max=32,
    _recyle={metal=4,tech=10,colour=5},
    _uncraftable=true,
    inventory_image="items_ram.png",
})
