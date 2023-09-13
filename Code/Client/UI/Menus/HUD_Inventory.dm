// Code for the inventory menu
obj/hud/menu/inventory
	icon_state = "inventory"
	menu_items = list()
	New()
		. = ..()
		// This adds all of the inventory slots to our menu_items.
		// But we only want to see 5 at a time, so that is handled differently.
		for(var/i = 0; i < INVENTORY_SIZE_LIMIT; i++)
			var/obj/hud/button/ic = new()
			ic.parent_menu = src
			ic.layer = layer + 1
			ic.button_id = i
			ic.maptext = "<font size=1>[i] EMPTY"
			menu_items += ic

		UpdateDisplayedSlots()