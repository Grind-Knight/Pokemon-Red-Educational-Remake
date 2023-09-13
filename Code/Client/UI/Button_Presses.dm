client
	var
		tmp
			client_state = IN_GAME
			list/obj/hud/menu/menu_stack = list()

client
	verb
		Test_Menu_Stack()
			world << "Checking menu stack."
			for(var/i in menu_stack)
				world << i

client
	proc
		UpdateClientState(new_state)
			client_state = new_state

client
	proc
		StartButton()
			switch(client_state)
				if(IN_GAME)
					if(!menu_stack.len)
						vis_contents_map["main_menu"].OpenMenu(src)  // Open the main menu if no menu is open
				if(IN_MENU)
					if(menu_stack.len)
						var/obj/hud/menu/current_menu = menu_stack[menu_stack.len]
						current_menu.CloseMenu(src)

						if(!menu_stack.len)
							UpdateClientState(IN_GAME)

client
	proc
		SelectButton()
			if(!menu_stack.len) return

client
	proc
		InteractButton()
			if(client_state == IN_MENU)	// If we're in the menu.
				switch(vis_contents_map["cursor"].target.type)
					if(/obj/hud/menu/main_menu)	// Cursor is over the MAIN MENU
						switch(vis_contents_map["cursor"].target.menu_items[vis_contents_map["cursor"].current_pos].button_id)
							if("POKéDEX")
								src << "Selected POKéDEX."
							if("POKéMON")
								src << "Selected POKéMON."
							if("ITEM")
								src << "Selected ITEM."
								vis_contents_map["inventory"].ToggleMenu(src)

							if("TRAINER")
								src << "Selected TRAINER."
							if("SAVE")
								src << "Selected SAVE."
							if("OPTION")
								src << "Selected OPTION."
							if("EXIT")
								src << "Selected EXIT."
							else
								src << "Something broke in InteractButton()."
				
					if(/obj/hud/menu/inventory/)	// Cursor is over an inventory slot
						if(mob.inventory[vis_contents_map["cursor"].current_pos].stored_item) mob.inventory[vis_contents_map["cursor"].current_pos].stored_item.Use()

					if(/obj/hud/menu/dialogue/)
						src << "Trying to interact with the dialogue menu!"
						ProgressDialogue()

client
	proc
		BackButton()
			if(!menu_stack.len) return

client
	proc
		CursorMove(move_dir = SOUTH)
			if(!vis_contents_map["cursor"].target) return	// Only move if we have a target.

			var/current_cursor_pos = vis_contents_map["cursor"].current_pos
			var/menu_items_length = vis_contents_map["cursor"].target.menu_items.len
			var/obj/hud/menu/inventory/inventory_menu = vis_contents_map["inventory"]

			switch(move_dir)
				if(SOUTH)
					if(current_cursor_pos < menu_items_length) 
						vis_contents_map["cursor"].current_pos++
					else 
						vis_contents_map["cursor"].current_pos = 1

					// Check if the cursor moved past the last displayed slot in the inventory
					if(vis_contents_map["cursor"].target == inventory_menu)  // Inventory-specific logic
						if(vis_contents_map["cursor"].current_pos > inventory_menu.current_displayed_start + 4)
							inventory_menu.current_displayed_start++
							inventory_menu.UpdateDisplayedSlots()
						// Handle the wrapping case from bottom to top
						else if(vis_contents_map["cursor"].current_pos == 1)
							inventory_menu.current_displayed_start = 1
							inventory_menu.UpdateDisplayedSlots()

				if(NORTH)
					if(current_cursor_pos > 1) 
						vis_contents_map["cursor"].current_pos--
					else 
						vis_contents_map["cursor"].current_pos = menu_items_length

					// Check if the cursor moved before the first displayed slot in the inventory
					if(vis_contents_map["cursor"].target == inventory_menu)  // Inventory-specific logic
						if(vis_contents_map["cursor"].current_pos < inventory_menu.current_displayed_start)
							inventory_menu.current_displayed_start--
							inventory_menu.UpdateDisplayedSlots()
						// Handle the wrapping case from top to bottom
						else if(vis_contents_map["cursor"].current_pos == menu_items_length)
							inventory_menu.current_displayed_start = max(1, menu_items_length - 4)
							inventory_menu.UpdateDisplayedSlots()

			// Call MoveCursor for the current position
			vis_contents_map["cursor"].target.menu_items[vis_contents_map["cursor"].current_pos].MoveCursor(src)