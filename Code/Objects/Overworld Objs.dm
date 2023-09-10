obj
	dense_obj
		icon = 'Assets/Sprites/Turfs/voidwall.dmi'
		icon_state = "object"
		density = 1	//Setting this true in case we ever change the parent obj density.
		layer = EFFECTS_LAYER
		New(loc)
			. = ..()
			alpha = 100

proc
	setup_dense_tiles(starting_loc, width, height, ignore_locs = list())
		for(var/i = 0; i < height; i++)
			for(var/j = 0; j < width; j++)
				var/newLoc = locate(starting_loc:x + j, starting_loc:y + i, starting_loc:z)
				if(!(newLoc in ignore_locs)) new/obj/dense_obj(newLoc)

obj
	density = 1	// All objects are dense by default so you can't walk through them.

	// Later we will setup bound_width and bound_height on New() to make sure objects aren't limited to world size for bounding.

//Teleporter
obj/teleporter
	Pallet
	Viridian
	Pewter
	icon = 'Assets/Sprites/Turfs/voidwall.dmi'
	icon_state = "teleport"
	New(loc)
		. = ..()
		alpha = 0
	density = 0
	var
		list/new_location = list(1, 1, 1)	// The new location to go to when using this teleporter
		walk_direction = null	// If the mob needs to step in a direction after teleporting
	Crossed(atom/movable/o)	// Something walking onto a teleporter.
		if(istype(o, /mob/player))	// If that something is a player...
			var/mob/player/p = o
			Teleport(p)



obj/teleporter
	proc
		Teleport(mob/M)
			set waitfor = FALSE	// Makes the proc function as if it was "spawned"
			if(!M.flags[TELEPORT_FLAG])
				M.flags[TELEPORT_FLAG] = TRUE
				var/old_dir = M.dir
				
				if(M.client) M.client.FadeToBlack()	// Found in Code\Client\UI\HUD.dm
				sleep(5)

				M.Move(locate(new_location[1], new_location[2], new_location[3]))
				M.dir = old_dir

				if(M.client) M.client.FadeIn()
				sleep(3)
				if(walk_direction) step(M, walk_direction)	// If we need to auto move after a teleport
				sleep(3)

				M.flags[TELEPORT_FLAG] = FALSE	// No longer teleporting
//End of teleporter


//Buildings
obj/buildings
	density = 0	// Buildings aren't dense here because we setup custom density obj's for them to allow door usage.

obj/buildings	
	var
		tiles_wide = 1	// How wide we should set the density tiles for the building.
		tiles_tall = 1	// How tall we should set the density tiles for the building.
		list/door_locs = list(list(1, 1))	// The x/y coordinate of the door, relative to the bottom left (starting point) of the building.

obj/buildings
	New(loc)
		. = ..()
		var/ignore_locations = list()
		for(var/list/d in door_locs)
			var/doorLoc = locate(x + d[1] - 1, y + d[2] - 1, z)
			ignore_locations += doorLoc
		setup_dense_tiles(loc, tiles_wide, tiles_tall, ignore_locations)

obj
	buildings
		Four_by_Two
			icon = 'Assets/Sprites/Objects/Buildings/64x32.dmi'
			tiles_wide = 4
			tiles_tall = 2
			door_locs = list(list(2, 1))
		Four_by_Three
			icon = 'Assets/Sprites/Objects/Buildings/64x48.dmi'
			tiles_wide = 4
			tiles_tall = 3
			door_locs = list(list(2, 1))
		Four_by_Four
			icon = 'Assets/Sprites/Objects/Buildings/64x64.dmi'
			tiles_wide = 4
			tiles_tall = 4
			door_locs = list(list(2, 1))
		Six_by_Four
			icon = 'Assets/Sprites/Objects/Buildings/96x64.dmi'
			tiles_wide = 6
			tiles_tall = 4
			door_locs = list(list(3, 1))
		Eight_by_Six
			icon = 'Assets/Sprites/Objects/Buildings/128x96.dmi'
			tiles_wide = 8
			tiles_tall = 6
			door_locs = list(list(5, 1))
		Twelve_by_Six
			icon = 'Assets/Sprites/Objects/Buildings/112x96.dmi'
			tiles_wide = 12
			tiles_tall = 6
			door_locs = list(list(7, 1))
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

obj/buildings
	Four_by_Two
		icon = 'Assets/Sprites/Objects/Buildings/64x32.dmi'
		tiles_wide = 4
		tiles_tall = 2
		door_locs = list(list(2, 1))
	Four_by_Three
		icon = 'Assets/Sprites/Objects/Buildings/64x48.dmi'
		tiles_wide = 4
		tiles_tall = 3
		door_locs = list(list(2, 1))
	Four_by_Four
		icon = 'Assets/Sprites/Objects/Buildings/64x64.dmi'
		tiles_wide = 4
		tiles_tall = 4
		door_locs = list(list(2, 1))
	Six_by_Four
		icon = 'Assets/Sprites/Objects/Buildings/96x64.dmi'
		tiles_wide = 6
		tiles_tall = 4
		door_locs = list(list(3, 1))
//End of buildings

//Indoor objects
obj/objs_indoor
	One_by_one
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
obj/objs_outdoor
	One_by_One
		icon = 'Assets/Sprites/Objects/Outdoor Objects/16x16.dmi'
//End of outdoor objects.