mob/player
	verb
		Abra()
			set category = "Test Verbs"
			var/list/locations = list(
				"Pallet Town" = locate(101, 147, 1),
				"Viridian City" = locate(109, 199, 1),
				"Pewter City" = locate(99, 307, 1),
				"Mt. Moon" = locate(188, 336, 1),
			)

			var/choice = input("Select a new location.") as null|anything in locations
			if(choice)
				loc = locations[choice]
				src << "Abra teleported you to [choice]!"