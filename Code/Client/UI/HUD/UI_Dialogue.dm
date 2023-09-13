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
	maptext_y = 22
	New()
		. = ..()
		var/obj/hud/button/ic = new()
		ic.parent_menu = src
		ic.cursor_style = "down"
		ic.button_id = 1
		ic.pixel_x = 162
		ic.pixel_y = 20
		menu_items += ic
	


// This verb functionality will be moved into an NPC proc so we can just handle dialogue that way
mob
	verb
		TestProc()
			var/longString = "The boy stood on the burning deck playing a game of cricket. The ball ran up his trouser leg and hit his middle wicket!"
			var/list/segments = SplitStringIntoSegments(longString)

			for(var/segment in segments)
				world << "Segment: [segment]"
			client.DialogueText(segments)




// Below is the actual code to handle the dialogue system
#define MAX_SEGMENT_LENGTH 29

proc/SplitStringIntoSegments(inputString)
	var/list/segments = list()
	var/segment = ""
	var/list/words = splittext(inputString, " ")

	for(var/word in words)
		if(length(segment) + length(word) + 1 <= MAX_SEGMENT_LENGTH)  // +1 for the space
			if(length(segment) > 0) segment += " "
			segment += word
		else
			segments += segment
			segment = word
	if(length(segment) > 0) segments += segment  // Add the remaining segment
	if(segments.len % 2) segments += ""
	
	return segments

client
	var/list/_text_to_show = list()

client
	proc
		DialogueText(list/newDialogue)
			_text_to_show = newDialogue
			vis_contents_map["dialogue"].ToggleMenu(src)
			ProgressDialogue()

client
	proc
		ProgressDialogue()
			set waitfor = FALSE
			
			if(_text_to_show.len)
				if(mob.flags[TEXT_POPULATING])
					vis_contents_map["dialogue"].maptext = BuildDialogueText(_text_to_show[1], _text_to_show[2])
					_text_to_show.Remove(_text_to_show[1], _text_to_show[2])
					mob.flags[TEXT_POPULATING] = FALSE
				else
					PopulateDialogueText()
			else
				EndDialogue()

client
	proc
		BuildDialogueText(firstText, secondText)
			var/dialogue = "<font size=1><div style='text-align: left; vertical-align: top;'>[firstText]<br>[secondText]</div>"
			return dialogue

client
	proc
		PopulateDialogueText()
			mob.flags[TEXT_POPULATING] = TRUE
			vis_contents_map["dialogue"].maptext = ""
			
			for(var/i in 1 to length(_text_to_show[1]))
				vis_contents_map["dialogue"].maptext += "<font size=1><div style='text-align: left; vertical-align: top;'>[_text_to_show[1][i]]</div>"
				sleep(world.tick_lag)
				if(!mob.flags[TEXT_POPULATING]) break
			vis_contents_map["dialogue"].maptext += "<br>"
			if(_text_to_show.len >= 2)
				for(var/i in 1 to length(_text_to_show[2]))
					vis_contents_map["dialogue"].maptext += "<font size=1><div style='text-align: left; vertical-align: top;'>[_text_to_show[2][i]]</div>"
					sleep(world.tick_lag)
					if(!mob.flags[TEXT_POPULATING]) break
			if(mob.flags[TEXT_POPULATING])
				_text_to_show.Remove(_text_to_show[1], _text_to_show[2])
			mob.flags[TEXT_POPULATING] = FALSE

client
	proc
		EndDialogue()
			_text_to_show = list()
			vis_contents_map["dialogue"].maptext = ""
			vis_contents_map["dialogue"].ToggleMenu(src)
