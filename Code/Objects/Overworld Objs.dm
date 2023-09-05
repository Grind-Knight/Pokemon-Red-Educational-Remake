obj
	dense_obj
		icon = 'Assets/Sprites/Turfs/voidwall.dmi'
		density = 1	//Setting this true in case we ever change the parent obj density.
		layer = EFFECTS_LAYER
		New(loc)
			. = ..()
			alpha = 100

proc
	setup_dense_tiles(startingLoc, width, height, ignoreLoc = list())
		for(var/i = 0; i < height; i++)
			for(var/j = 0; j < width; j++)
				var/newLoc = locate(startingLoc:x + j, startingLoc:y + i, startingLoc:z)
				if(!(newLoc in ignoreLoc))
					new/obj/dense_obj(newLoc)

obj
	density = 1

//Teleporter
obj
	teleporter
		icon = 'Assets/Sprites/Turfs/voidwall.dmi'
		icon_state = "teleport"
		New(loc)
			. = ..()
			alpha = 0
		density = 0
		var
			list/new_location = list(1, 1, 1)
			walk_direction = null
		Crossed(atom/movable/o)
			if(istype(o, /mob/player))
				var/mob/player/p = o
				if(!p.flags[TELEPORT_FLAG])
					Teleport(p)

obj
	teleporter
		proc
			Teleport(mob/M)
				set waitfor = FALSE	// Makes the proc function as if it was "spawned".
				if(!M.flags[TELEPORT_FLAG])
					var/old_dir = M.dir
					M.flags[TELEPORT_FLAG] = TRUE

					if(M.client) M.client.FadeToBlack()
					sleep(5)

					M.Move(locate(new_location[1], new_location[2], new_location[3]))
					M.dir = old_dir

					if(M.client) M.client.FadeIn()
					sleep(3)
					if(walk_direction) step(M, walk_direction)
					sleep(3)

					M.flags[TELEPORT_FLAG] = FALSE

mob
	Bump(Obstacle)
		. = ..()
		if(istype(Obstacle, /obj/teleporter))
			var/obj/teleporter/tele = Obstacle
			tele.Teleport(src)
//End of teleporter


//Buildings
obj
	buildings
		density = 0//Buildings aren't dense here because we setup custom density obj's for them to allow door usage.

obj
	buildings
		var
			tiles_wide = 1
			tiles_tall = 1
			list/door_loc = list(1, 1)

obj
	buildings
		New(loc)
			. = ..()
			setup_dense_tiles(loc, tiles_wide, tiles_tall, list(locate(x + door_loc[1] - 1, y + door_loc[2] - 1, z)))

obj
	buildings
		Four_by_Two
			icon = 'Assets/Sprites/Objects/Buildings/64x32.dmi'
			tiles_wide = 4
			tiles_tall = 2
			door_loc = list(2, 1)
		Four_by_Three
			icon = 'Assets/Sprites/Objects/Buildings/64x48.dmi'
			tiles_wide = 4
			tiles_tall = 3
			door_loc = list(2, 1)
		Four_by_Four
			icon = 'Assets/Sprites/Objects/Buildings/64x64.dmi'
			tiles_wide = 4
			tiles_tall = 4
			door_loc = list(2, 1)
		Six_by_Four
			icon = 'Assets/Sprites/Objects/Buildings/96x64.dmi'
			tiles_wide = 6
			tiles_tall = 4
			door_loc = list(3, 1)
		Eight_by_Six
			icon = 'Assets/Sprites/Objects/Buildings/128x96.dmi'
			tiles_wide = 8
			tiles_tall = 6
			door_loc = list(5, 1)
		Twelve_by_Six
			icon = 'Assets/Sprites/Objects/Buildings/112x96.dmi'
			tiles_wide = 12
			tiles_tall = 6
			door_loc = list(7, 1)
//End of buildings

//Indoor objects
obj
	objs_indoor
		One_by_One
			icon = 'Assets/Sprites/Objects/Indoor Objects/16x16.dmi'
		One_by_Two
			icon = 'Assets/Sprites/Objects/Indoor Objects/16x32.dmi'
		Two_by_Two
			icon = 'Assets/Sprites/Objects/Indoor Objects/32x32.dmi'
		Two_by_Three
			icon = 'Assets/Sprites/Objects/Indoor Objects/32x48.dmi'
		Three_by_Two
			icon = 'Assets/Sprites/Objects/Indoor Objects/48x32.dmi'
		Four_by_Three
			icon = 'Assets/Sprites/Objects/Indoor Objects/64x48.dmi'
//End of indoor objects.

//Outdoor objects.
obj
	objs_outdoor
		One_by_One
			icon = 'Assets/Sprites/Objects/Outdoor Objects/16x16.dmi'
		Two_by_Two
			icon = 'Assets/Sprites/Objects/Outdoor Objects/32x32.dmi'
//End of outdoor objects.