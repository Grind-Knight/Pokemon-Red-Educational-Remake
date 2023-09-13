// Code for the main menu (what you see when you press start)
obj/hud/menu/main_menu
	icon_state = "main"
	pixel_x = 40
	pixel_y = 48
	menu_items = list("POKéDEX", "POKéMON", "ITEM", "TRAINER", "SAVE", "OPTION", "EXIT")
	New(loc)
		. = ..()
		var/height_counter = 0
		var/list/old_menu_items = menu_items
		menu_items = list()
		for(var/i in old_menu_items)
			var/obj/hud/button/ic = new()
			ic.parent_menu = src
			ic.layer = layer + 1
			ic.button_id = i
			ic.maptext = "<font size=1>[i]"
			ic.pixel_x = 103
			ic.pixel_y = 136 + height_counter
			height_counter -= 16
			menu_items += ic
			vis_contents.Add(ic)