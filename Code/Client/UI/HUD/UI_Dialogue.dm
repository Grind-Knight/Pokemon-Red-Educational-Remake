/*
All of the HUD code regarding the dialogue.

Not the specific interaction code though. Check out: Code\Client\UI\Button_Presses.dm
*/

client
	verb
		Dialogue_Toggle()
			vis_contents_map["dialogue"].ToggleMenu(src)
			

obj/hud/menu/dialogue   // The base dialogue menu used in more than dialogue. It's in combat and stuff too
	icon_state = "bottom_menu"
	pixel_x = 16
	maptext_width = 144
	maptext_height = 32
	maptext_x = 16
	maptext_y = 24
	New()
		. = ..()
		var/obj/hud/button/ic = new()
		ic.parent_menu = src
		ic.cursor_style = "down"
		ic.button_id = 1
		ic.pixel_x = 162
		ic.pixel_y = 20
		menu_items += ic
	
mob
	verb
		Send_Text(T as text)
			client.DialogueText(T)

proc/splitStringIntoSegments(str)
	var/list/segments = list()
	var/segment = ""
	var/list/words = splittext(str, " ")

	for(var/word in words)
		if(length(segment) + length(word) + 1 <= 18)  // +1 for the space
			if(length(segment) > 0)
				segment += " "
			segment += word
		else
			segments += segment
			segment = word
	if(length(segment) > 0)
		segments += segment  // Add the remaining segment
	if(segments.len % 2)
		segments += ""

	return segments

// Test the proc
mob/verb/TestProc()
	var/long_string = "The boy stood on the burning deck playing a game of cricket. The ball ran up his trouser leg and hit his middle wicket!"
	var/list/segments = splitStringIntoSegments(long_string)

	for(var/segment in segments)
		world << "Segment: [segment]"
	client.DialogueText(segments)
	

client
	proc
		DialogueText(list/new_dialogue)
			text_to_show = new_dialogue
			vis_contents_map["dialogue"].ToggleMenu(src)
			ProgressDialogue()

	proc
		ProgressDialogue()
			set waitfor = FALSE
			
			if(text_to_show.len)
				if(mob.flags[TEXT_POPULATING])
					world << "Instantly finish text"
					vis_contents_map["dialogue"].maptext = ""
					vis_contents_map["dialogue"].maptext = "<div style='text-align: left; vertical-align: top;'>[text_to_show[1]]<br>[text_to_show[2]]</div>"
					text_to_show.Remove(text_to_show[1], text_to_show[2])
					mob.flags[TEXT_POPULATING] = FALSE
				else					
					mob.flags[TEXT_POPULATING] = TRUE
					vis_contents_map["dialogue"].maptext = ""
					
					for(var/i in 1 to length(text_to_show[1]))
						world << i
						vis_contents_map["dialogue"].maptext += "<div style='text-align: left; vertical-align: top;'>[text_to_show[1][i]]</div>"
						sleep(world.tick_lag)
						if(!mob.flags[TEXT_POPULATING]) break
					vis_contents_map["dialogue"].maptext += "<br>"
					if(text_to_show.len >= 2)
						for(var/i in 1 to length(text_to_show[2]))
							vis_contents_map["dialogue"].maptext += "<div style='text-align: left; vertical-align: top;'>[text_to_show[2][i]]</div>"
							sleep(world.tick_lag)
							if(!mob.flags[TEXT_POPULATING]) break
					if(mob.flags[TEXT_POPULATING])
						text_to_show.Remove(text_to_show[1], text_to_show[2])
					mob.flags[TEXT_POPULATING] = FALSE
			else
				text_to_show = list()
				vis_contents_map["dialogue"].maptext = ""
				vis_contents_map["dialogue"].ToggleMenu(src)
client
	var/list/text_to_show = list()



