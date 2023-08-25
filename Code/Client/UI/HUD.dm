client
	var
		color_filter // Variable to store the client's color filter

	New() // Client constructor
		. = ..() // Calls the parent constructor
		var/obj/plane_master = new // Creates a new plane master object
		screen += plane_master // Adds the plane master to the client's screen
		plane_master.appearance_flags = PLANE_MASTER // Sets the appearance flags to PLANE_MASTER
		plane_master.screen_loc = "CENTER,CENTER" // Centers the plane master on the client's screen

		// Adds a color filter to the plane master with RGB color space
		plane_master.filters += filter(
			type = "color",
			color = null,
			space = FILTER_COLOR_RGB)
		// Stores the reference to the color filter in the client's color_filter variable
		color_filter = plane_master.filters[plane_master.filters.len]

client
	proc
		FadeToBlack()
			var/list/color_matrix = list(
				0, 0, 0,
				0, 0, 0,
				0, 0, 0
			)
			animate(
				color_filter,
				color = color_matrix,
				time = 5
			)

client
	proc
		FadeIn()
			var/list/color_matrix = list(
				1, 0, 0,
				0, 1, 0,
				0, 0, 1
			)
			animate(
				color_filter,
				color = color_matrix,
				time = 5
			)