/*
Steps for combat:

-Combat begins.
-Animate the screen fade in stuff.
-Dialogue box appears.
-Player and pokemon (or other trainer) slide into the screen.
-"Wild POKEMON appeared!" || "BLUE wants to battle!"
-Press interact.
-Player animates out of screen (left).
-"GO SQUIRTLE"
-Squirtle health menu appears.
-Sendout animation
-Squirtle appears
-Fight option menu appear layered on TOP of dialogue box: FIGHT, PKMN, ITEM, RUN
-WASD to navigate menus:
   -FIGHT: 4 moves (NEW MENU) appear along with type and 20/25 (another new menu on top)
   -PKMN: Show list of pokemon: CHOOSE A POKEMON.
   -ITEM: SHOWS LIST OF ITEMS.
   -RUN: "Got away safely dialogue". Combat menu closes.
      -Press A and the menus all close and you're back in the overworld standing in the grass.
*/

client
   verb
      Dialogue_Toggle()
         vis_contents_map["dialogue"].ToggleMenu(src)

obj/hud/menu/dialogue   // The base dialogue menu used in more than dialogue. It's in combat and stuff too
   icon_state = "bottom_menu"
   pixel_x = 16
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
    Poke_Verb(mob/M in view())
      PokeProc(M)

mob
  proc
    PokeProc(mob/mob_to_poke)
      world << "Mob calling PokeProc is [src]. The mob we're passing in is: [mob_to_poke]."


/*
	New(loc)
		. = ..()
		var/height_counter = 0
		var/list/old_menu_items = menu_items
		menu_items = list()
		for(var/i in old_menu_items)
			var/obj/hud/button/ic = new()
			ic.parent_menu = src
			ic.layer = layer + 1
			ic.button_id = i
			ic.maptext = "<font size=1>[i]"
			ic.pixel_x = 103
			ic.pixel_y = 136 + height_counter
			height_counter -= 16
			menu_items += ic
			vis_contents.Add(ic)
*/