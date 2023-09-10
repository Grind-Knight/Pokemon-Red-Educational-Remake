turf
	outdoor
		icon = 'Assets/Sprites/Turfs/outdoor.dmi'
		var/jumpable = 0
		var/jump_dir = null
	
	indoor
		icon = 'Assets/Sprites/Turfs/indoor.dmi'
	
	void_wall
		icon = 'Assets/Sprites/Turfs/voidwall.dmi'
		density = 1
		opacity = 1
		New()
			alpha = 0
			..()
	















// obj
// 	pallet
// 		buildings
// 			house
// 				icon = 'Assets/Sprites/Objects/Buildings/64x48.dmi'
// 				icon_state = "pink_house"
// 				// New()
// 				// 	var/icon/I = new icon('Assets/Sprites/Objects/Buildings/64x48.dmi') // Create an icon object
// 				// 	I.SwapColor(rgb(255, 000, 102, 255), rgb(000, 255, 000, 255)) // Call SwapColor on the icon object
// 				// 	icon = I

// mob
// 	verb
// 		Recolor_Test()
// 			var/icon/newIcon
// 			for(var/turf/o in view(50, src))
// 				newIcon = new(o.icon)
// 				newIcon.SwapColor(rgb(200, 224, 216), rgb(160, 31, 42))
// 				o.icon = newIcon



/*
Entered()
	for all icons in range
		icon swapcolor pink to var

*/
