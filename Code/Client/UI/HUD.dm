// Define the plane_master object
obj/plane_master
	appearance_flags = PLANE_MASTER
	screen_loc = "CENTER,CENTER"

obj/screen
	screen_loc = "1, 1"
	plane = 1

client
	proc
		AddToVisContentsAndMap(key as text, obj_type)
			var/obj/created_instance = new obj_type (src)
			interface_overlay.vis_contents.Add(created_instance)
			vis_contents_map[key] = created_instance

client
	var
		obj/screen/interface_overlay = new // The main UI overlay object
		obj/plane_master/overlay_plane_master = new // Creates a new plane master object
		color_filter // Variable to store the client's color filter
		list/vis_contents_map = list()  // Associative list to map keys to visual objects

	New()
		. = ..()
		screen.Add(interface_overlay) // Add interface_overlay to client's screen
		screen.Add(overlay_plane_master) // Add plane_master to client's screen

		AddToVisContentsAndMap("cursor", /obj/hud/cursor)
		AddToVisContentsAndMap("main_menu", /obj/hud/menu/main_menu)
		AddToVisContentsAndMap("inventory", /obj/hud/menu/inventory)

		// Add a color filter to the plane master
		overlay_plane_master.filters += filter(
			type = "color",
			color = null,
			space = FILTER_COLOR_RGB)
		// Store the reference to the color filter in the client's color_filter variable
		color_filter = overlay_plane_master.filters[overlay_plane_master.filters.len]


// Code for the base hud for all menus
obj/hud
	icon = 'Assets/Sprites/UI/menu.dmi'
	appearance_flags = PIXEL_SCALE
	layer = HUD_LAYER
	var
		title
		list/menu_items = list()	// List of items within the menu
// End of our base hud


// Code for our cursor object
obj/hud/cursor
	icon = 'Assets/Sprites/UI/cursor.dmi'
	icon_state = "filled"
	alpha = 0	// Cursor is 'off' by default.
	layer = CURSOR_LAYER
	plane = 10
	var
		obj/hud/target = null
		current_pos = 1
// End of cursor


// Code for buttons within our menu
obj/hud/button	// Something that can be interacted with. A button.
	maptext = "default"
	maptext_width = 100
	var/obj/hud/parent_menu
	var
		button_id

obj/hud/button
	proc
		MoveCursor(client/C, move_time = world.tick_lag)	// Move the cursor to this menu (or button, mostly)
			// -8, 3 is just the offset for making the cursor look centered
			animate(
				C.vis_contents_map["cursor"],
				pixel_x = pixel_x + parent_menu.pixel_x + -8,
				pixel_y = pixel_y + parent_menu.pixel_y + 3,
				time = move_time
			)

// End of buttons


// Code for obj/hud/menu
obj/hud/menu
	var
		current_displayed_start = 1

obj/hud/menu
	layer = MENU_LAYER
	New()
		. = ..()
		alpha = 0	// Menu's are closed by default.
		var/matrix/M = matrix()
		M.Scale(0.1, 0.1)
		animate(src, transform = M)

obj/hud/menu
	proc
		ToggleMenu(client/C)
			if(src in C.menu_stack)
				CloseMenu(C)
			else
				OpenMenu(C)

obj/hud/menu
	proc
		OpenMenu(client/C)
			C.menu_stack += src
			
			// Make all open menu planes be set to 1. Along with their buttons
			for(var/obj/hud/menu/all_menus in C.menu_stack)
				all_menus.plane = 1
				for(var/obj/hud/button/B in all_menus.menu_items)
					B.plane = 1
			
			// Set the plane for current menu and their buttons to be 2
			for(var/obj/hud/button/B in menu_items)
				B.plane = 2
			plane = 2

			C.UpdateClientState(IN_MENU)

			C.vis_contents_map["cursor"].alpha = 255
			if(C.menu_stack.len)
				C.vis_contents_map["cursor"].target = C.menu_stack[C.menu_stack.len]
			else
				C.vis_contents_map["cursor"].target = null
				C.vis_contents_map["cursor"].alpha = 0

			C.vis_contents_map["cursor"].current_pos = 1
			if(C.vis_contents_map["cursor"].target.menu_items.len) C.vis_contents_map["cursor"].target.menu_items[1].MoveCursor(C)

			var/matrix/M = matrix()
			M.Scale(1, 1)
			animate(src, alpha = 255, transform = M, time = 1)

obj/hud/menu
	proc
		CloseMenu(client/C)
			C.menu_stack -= src

			if(C.menu_stack.len)
				world << "went to [C.menu_stack[C.menu_stack.len]]"
				C.vis_contents_map["cursor"].target = C.menu_stack[C.menu_stack.len]
				C.vis_contents_map["cursor"].current_pos = 1
				current_displayed_start = 1
				UpdateDisplayedSlots()
				if(C.vis_contents_map["cursor"].target.menu_items.len) C.vis_contents_map["cursor"].target.menu_items[1].MoveCursor(C)
			else
				world << "went to no target"
				C.vis_contents_map["cursor"].target = null
				C.vis_contents_map["cursor"].alpha = 0
				C.UpdateClientState(IN_GAME)

			var/matrix/M = matrix()
			M.Scale(0.1, 0.1)
			animate(src, alpha = 0, transform = M, time = 1)
			
			//C.vis_contents_map.Remove(src)
			// REMOVE MENU FROM VIS_CONTENTS INSTEAD OF SETTING ALPHA TO 0

obj/hud/menu
	proc
		UpdateDisplayedSlots()
			// Clear currently displayed slots
			vis_contents = list()

			var/height_counter = 0
			for(var/index = current_displayed_start to current_displayed_start + 4)
				var/obj/hud/button/current_button = menu_items[index]
				if(current_button)  // Check if the button exists
					vis_contents.Add(current_button)
					current_button.pixel_x = 56
					current_button.pixel_y = 123 - height_counter
					height_counter += 15
// End of obj/hud/menu


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
// End of main menu


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
// End of the inventory


//Client side effects for the screen. Fading in/out, color changes, etc.
client
	proc
		FadeToBlack(fade_time = 5)
			var/list/color_matrix = list(
				0, 0, 0,
				0, 0, 0,
				0, 0, 0
			)
			animate(
				color_filter,
				color = color_matrix,
				time = fade_time
			)

client
	proc
		FadeIn(fade_time = 5)
			var/list/color_matrix = list(
				1, 0, 0,
				0, 1, 0,
				0, 0, 1
			)
			animate(
				color_filter,
				color = color_matrix,
				time = fade_time
			)