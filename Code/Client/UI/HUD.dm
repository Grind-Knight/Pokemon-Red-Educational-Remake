// Define the plane_master object
obj/plane_master
	appearance_flags = PLANE_MASTER
	screen_loc = "CENTER,CENTER"

client
	var
		obj/interface_overlay = new // The main UI overlay object
		obj/plane_master/overlay_plane_master = new // Creates a new plane master object
		color_filter // Variable to store the client's color filter

	New()
		. = ..()
		screen.Add(interface_overlay) // Add interface_overlay to client's screen
		screen.Add(overlay_plane_master) // Add plane_master to client's screen

		// Add more UI elements to interface_overlay
		//interface_overlay.vis_contents.Add(new/obj/inventory)
		//interface_overlay.vis_contents.Add(new/obj/dialogue)
		// etc.

		// Add a color filter to the plane master
		overlay_plane_master.filters += filter(
			type = "color",
			color = null,
			space = FILTER_COLOR_RGB)
		// Store the reference to the color filter in the client's color_filter variable
		color_filter = overlay_plane_master.filters[overlay_plane_master.filters.len]


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