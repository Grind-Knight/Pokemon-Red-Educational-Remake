proc/add_filter(atom/atom, filter)
	atom.filters += filter
	return atom.filters[atom.filters.len]

obj/tall_grass_body_double
	parent_type = /obj
	layer = (TURF_LAYER + OBJ_LAYER) / 2
	vis_flags = VIS_INHERIT_ICON | VIS_INHERIT_ICON_STATE | VIS_INHERIT_DIR

mob
	var/const/HEAD_MASK_ICON = 'Assets/Sprites/Mobs/head_mask.dmi'
	var/global/obj/tall_grass_body_double/_tall_grass_body_double
	var/tmp/_head_mask_filter

	Move(NewLoc, Dir, step_x, step_y)
		var/was_on_tall_grass = IsOnTallGrass()
		. = ..()
		var/is_on_tall_grass = IsOnTallGrass()
		if(was_on_tall_grass != is_on_tall_grass)
			if(is_on_tall_grass)
				EnterTallGrass()
			else
				ExitTallGrass()

	proc/IsOnTallGrass()
		return loc?.icon_state == "tall_grass"

	proc/EnterTallGrass()
		vis_contents += _tall_grass_body_double ||= new
		_head_mask_filter = add_filter(src, filter(type = "alpha", icon = HEAD_MASK_ICON))

	proc/ExitTallGrass()
		vis_contents -= _tall_grass_body_double
		filters -= _head_mask_filter
