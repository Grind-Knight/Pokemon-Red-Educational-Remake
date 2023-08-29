client
	var
		tmp
			client_state = IN_GAME

			list/obj/hud/menu/menu_stack = list()

client
	Stat()
		. = ..()
		stat("Client State:", client_state)

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

			//menu_stack[1].OnButtonPressStart(src)


client
	proc
		SelectButton()
			if(!menu_stack.len) return

			menu_stack[1].OnButtonPressSelect(src)

client
	proc
		InteractButton()
			if(client_state == IN_MENU)	// If we're in the menu.
				vis_contents_map["cursor"].target.menu_items[vis_contents_map["cursor"].current_pos].OnButtonPressInteract(src)

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


client
	proc
		BackButton()
			if(!menu_stack.len) return

			menu_stack[1].OnButtonPressBack(src)

client
	proc
		CursorMove(move_dir = SOUTH)
			if(!vis_contents_map["cursor"].target) return	// Only move if we have a target.

			var/current_cursor_pos = vis_contents_map["cursor"].current_pos
			var/menu_items_length = vis_contents_map["cursor"].target.menu_items.len

			//This is the easiest to read chunk of code to accomplish this task.
			//There are two other methods below that accomplish the same thing.
			switch(move_dir)
				if(SOUTH)
					if(current_cursor_pos < menu_items_length) vis_contents_map["cursor"].current_pos++
					else vis_contents_map["cursor"].current_pos = 1
				if(NORTH)
					if(current_cursor_pos > 1) vis_contents_map["cursor"].current_pos--
					else vis_contents_map["cursor"].current_pos = menu_items_length
			
			/*
			//This is the same as the above commented out code. Look up "ternary" for the below formatting. 

			switch(move_dir)
				if(SOUTH)
					vis_contents_map["cursor"].current_pos = (current_cursor_pos < menu_items_length) ? current_cursor_pos + 1 : 1
				if(NORTH)
					vis_contents_map["cursor"].current_pos = (current_cursor_pos > 1) ? current_cursor_pos - 1 : menu_items_length
			*/

			/*
			//This is the least amount of lines but it's unnecessarily complex. It does the same thing.
			//However it's not as easy to read so this isn't always suggested.

			switch(move_dir)
				if(SOUTH) current_cursor_pos = !(current_cursor_pos < menu_items_length) || current_cursor_pos + 1
				if(NORTH) current_cursor_pos = --current_cursor_pos || menu_items_length
			vis_contents_map["cursor"].current_pos = current_cursor_pos
			*/


			vis_contents_map["cursor"].target.menu_items[vis_contents_map["cursor"].current_pos].MoveCursor(src)