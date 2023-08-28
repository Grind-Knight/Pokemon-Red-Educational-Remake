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
			var/obj/created_instance = new obj_type
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

		AddToVisContentsAndMap("main_menu", /obj/hud/main_menu)

		// Add a color filter to the plane master
		overlay_plane_master.filters += filter(
			type = "color",
			color = null,
			space = FILTER_COLOR_RGB)
		// Store the reference to the color filter in the client's color_filter variable
		color_filter = overlay_plane_master.filters[overlay_plane_master.filters.len]



obj/hud
	icon = 'Assets/Sprites/UI/menu.dmi'
	alpha = 0	// Menu's are closed by default.
	var
		title
		menu_items	// List of items within the menu

obj/hud
	New(loc)
		. = ..()
		var/matrix/M = matrix()
		M.Scale(0.1, 0.1)
		animate(src, transform = M)


obj/hud
	proc
		OpenMenu(client/C)
			C.menu_stack += src
			C.UpdateClientState("IN_MENU")
			
			var/matrix/M = matrix()
			M.Scale(1, 1)
			animate(src, alpha = 255, transform = M, time = 2)


obj/hud
	proc
		CloseMenu(client/C)
			C.menu_stack -= src
			C.UpdateClientState("IN_GAME")

			var/matrix/M = matrix()
			M.Scale(0.1, 0.1)
			animate(src, alpha = 0, transform = M, time = 2)

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



obj/hud/main_menu
	icon_state = "main"
	pixel_x = 40
	pixel_y = 48








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