// turf
// 	pallet
// 		outdoor
// 			icon = 'Assets/Sprites/Turfs/outdoor.dmi'

// obj
// 	pallet
// 		buildings
// 			house
// 				icon = 'Assets/Sprites/Objects/Buildings/64x48.dmi'
// 				icon_state = "pink_house"




























///TEST BEGINS HERE
// mob
// 	verb
// 		Recolor_Test()		
// 			var/icon/newIcon
// 			for(var/obj/o in view(50, src))
// 				newIcon = new(o.icon)	
// 				newIcon.SwapColor(rgb(255, 0, 102), rgb(159, 192, 157))
// 				o.icon = newIcon

// var
// 	original_color = rgb(255, 0, 102)
// 	target_colors = list(rgb(159, 192, 157), rgb(100, 150, 200)) // Add more colors here
// 	color_cache = list() // A mapping between obj type, original color, and swapped icon

// world
// 	New()
// 		. = ..()
// 		for(var/obj/o in world)
// 			for(var/swapped_color in target_colors)
// 				// Check if the icon has already been swapped and cached
// 				if(color_cache[o.type] && color_cache[o.type][original_color] && color_cache[o.type][original_color][swapped_color])
// 					continue // Skip this color if it's already cached

// 				var/icon/newIcon = new(o.icon)
// 				newIcon.SwapColor(original_color, swapped_color)

// 				// Cache the swapped icon
// 				if(!color_cache[o.type])
// 					color_cache[o.type] = list()
// 				if(!color_cache[o.type][original_color])
// 					color_cache[o.type][original_color] = list()
// 				color_cache[o.type][original_color][swapped_color] = newIcon

// mob
// 	verb
// 		Choose_Color()
// 			var/choice = input("Choose a color:", "Color", null) as null|anything in list("Green", "Blue") // Corresponding to target_colors
// 			var/chosen_color = target_colors[choice == "Green" ? 1 : 2] // Index into target_colors based on choice

// 			for(var/obj/o in view(50, src))
// 				var
// 				original_color = rgb(255, 0, 102)

// 				// Use cached icon if available
// 				if(color_cache[o.type] && color_cache[o.type][original_color] && color_cache[o.type][original_color][chosen_color])
// 					o.icon = color_cache[o.type][original_color][chosen_color]


// client
// 	var
// 		color_filter // Variable to store the client's color filter

// 	New() // Client constructor
// 		. = ..() // Calls the parent constructor
// 		var/obj/plane_master = new // Creates a new plane master object
// 		screen += plane_master // Adds the plane master to the client's screen
// 		plane_master.appearance_flags = PLANE_MASTER // Sets the appearance flags to PLANE_MASTER
// 		plane_master.screen_loc = "CENTER,CENTER" // Centers the plane master on the client's screen

// 		// Adds a color filter to the plane master with RGB color space
// 		plane_master.filters += filter(
// 			type = "color",
// 			color = null,
// 			space = FILTER_COLOR_RGB)
// 		// Stores the reference to the color filter in the client's color_filter variable
// 		color_filter = plane_master.filters[plane_master.filters.len]

	// verb
	// 	Swap_Green_To_Blue()
	// 		// Simple green-blue swap matrix
	// 		// The default color matrix is:
	// 		/*
	// 			1, 0, 0
	// 			0, 1, 0
	// 			0, 0, 1
	// 		*/
	// 		//^ This is just R = 1, G = 1, B = 1.
	// 		//So below we swap G into B on the second line, and B to G on the third.
	// 		var/list/color_matrix = list(
	// 			1, 0, 0,	//R G B
	// 			0, 0, 1,	//R G B
	// 			0, 1, 0	//R G B
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)

	// verb
	// 	Swap_Green_To_Red()
	// 		var/list/color_matrix = list(
	// 			0, 0, 1,
	// 			0, 1, 0,
	// 			1, 0, 0
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)

	// verb
	// 	Swap_Red_To_Green()
	// 		var/list/color_matrix = list(
	// 			0, 0, 0.5,
	// 			0, 1, 0,
	// 			1, 0, 0
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)

	// verb
	// 	Default_Colors()
	// 		var/list/color_matrix = list(
	// 			1, 0, 0,
	// 			0, 1, 0,
	// 			0, 0, 1
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)


	// verb
	// 	Cerulean_City()
	// 		var/list/color_matrix = list(
	// 			1, 0, 0.1, // Maintain the red channel, add a slight blue tint
	// 			0, 1, 0.1, // Maintain the green channel, add a slight blue tint
	// 			0, 0, 1.2  // Enhance the blue channel
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)



	// verb
	// 	Invert_Colors()
	// 		var/list/color_matrix = list(
	// 			-1, 0, 1,
	// 			0, -1, 1,
	// 			0, 0, -1
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)


	// verb
	// 	Grayscale()
	// 		var/list/color_matrix = list(
	// 			0.33, 0.33, 0.33,
	// 			0.33, 0.33, 0.33,
	// 			0.33, 0.33, 0.33
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)





	// verb
	// 	Increase_Red()
	// 		var/list/color_matrix = list(
	// 			100, 0, 0,
	// 			0, 1, 0,
	// 			0, 0, 1
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)

	// verb
	// 	Warm_Effect()
	// 		var/list/color_matrix = list(
	// 			1, 0, 0,
	// 			0, 0.5, 0,
	// 			0, 0, 0.5
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)

	// verb
	// 	Test_Swap()
	// 		var/list/color_matrix = list(
	// 			1, 0.5, 0.5,	//R
	// 			0, 1, 0,	//G
	// 			0, 0, 1	//B
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)


	// verb
	// 	T_200_IQ(r as num, g as num, b as num)
	// 		var/list/color_matrix = list(
	// 			r, g, b,
	// 			1, 1, 1,
	// 			0, 0, 0
	// 		)
	// 		animate(
	// 			color_filter,
	// 			color = color_matrix,
	// 			time = 10
	// 		)


/*	
Entered()
	for all icons in range
		icon swapcolor pink to var

*/
