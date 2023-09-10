mob/player
	Bump(Obstacle)	// Mob bumping into something.
		. = ..()
		if(istype(Obstacle, /obj/teleporter))	// If that something is a teleporter...
			var/obj/teleporter/tele = Obstacle
			tele.Teleport(src)

		//The following block handles jumping over ledges.
		if(istype(Obstacle, /turf/outdoor))
			var/turf/outdoor/O = Obstacle
			if(O.jumpable && dir == O.jump_dir)
				var/my_x = x
				var/my_y = y
				var/my_z = z

				flags[TELEPORT_FLAG] = TRUE
				density = 0
				//Currently this handles SOUTH only. For EAST/WEST jumping, animate pixel_x instead of pixel_y.
				animate(src, pixel_y = 10, time = 2)
				animate(client, pixel_y = -20, time = 4)	//Animating the client makes it appear more smooth

				var/obj/Shadow/S = new(loc)	//New shadow object which is animated SOUTH.
				animate(S, pixel_y = -36, time = 4)

				walk_towards(src, locate(my_x, my_y-2, my_z), 1)	//Walk towards the new location (south two tiles) at a lag of 1

				spawn(2)
					animate(src, pixel_y = 4, time = 2)
					animate(client, pixel_y = 0)

				spawn(5)
					S.loc = null
					walk(src, 0)
					density = 1
					flags[TELEPORT_FLAG] = FALSE
