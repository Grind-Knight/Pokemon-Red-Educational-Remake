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

obj/hud
	icon = 'Assets/Sprites/UI/menu.dmi'
	appearance_flags = PIXEL_SCALE
	layer = HUD_LAYER
	var
		title
		list/menu_items = list()	// List of items within the menu


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

			C.UpdateClientState(IN_MENU)

			C.vis_contents_map["cursor"].alpha = 255
			if(C.menu_stack.len)
				//C.vis_contents_map["cursor"].target = C.menu_stack[C.menu_stack.len]
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
			C.UpdateClientState(IN_GAME)

			if(C.menu_stack.len)
				C.vis_contents_map["cursor"].target = C.menu_stack[C.menu_stack.len]
			else
				C.vis_contents_map["cursor"].target = null
				C.vis_contents_map["cursor"].alpha = 0

			var/matrix/M = matrix()
			M.Scale(0.1, 0.1)
			animate(src, alpha = 0, transform = M, time = 1)

obj/hud
	proc
		OnButtonPressStart(client/C)
			world << "Pressed Start on [src]."

obj/hud
	proc
		OnButtonPressSelect(client/C)
			world << "Pressed Select on [src]."

obj/hud
	proc
		OnButtonPressInteract(client/C)
			world << "Pressed Interact on [src]."

obj/hud
	proc
		OnButtonPressBack(client/C)
			world << "Pressed Back on [src]."

obj/hud/button	// Something that can be interacted with in the menu. A button.
	maptext = "default"
	maptext_width = 100
	layer = BUTTON_LAYER
	var/obj/hud/parent_menu
	var
		button_id


obj/hud/button
	proc
		MoveCursor(client/C, move_time = world.tick_lag)	// Move the cursor to this menu (or button, mostly)
			animate(
				C.vis_contents_map["cursor"],
				pixel_x = pixel_x + parent_menu.pixel_x + C.vis_contents_map["cursor"].offset_x,
				pixel_y = pixel_y + parent_menu.pixel_y + C.vis_contents_map["cursor"].offset_y,
				time = move_time
			)


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
			ic.button_id = i
			ic.maptext = "<font size=1>[i]"
			ic.pixel_x = 103
			ic.pixel_y = 136 + height_counter
			height_counter -= 16
			menu_items += ic
			vis_contents.Add(ic)

		// for(var/i in menu_items)
		// 	world << "[i]: [menu_items[i]]"

obj/hud/menu/inventory
	icon_state = "inventory"


obj/hud/cursor
	icon = 'Assets/Sprites/UI/cursor.dmi'
	icon_state = "filled"
	alpha = 0	// Cursor is 'off' by default.
	layer = CURSOR_LAYER
	var
		offset_x = -8
		offset_y = 3
		obj/hud/target = null
		current_pos = 1


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