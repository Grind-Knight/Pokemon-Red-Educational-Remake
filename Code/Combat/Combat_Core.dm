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

/*
mob/var
   Combat_Instance/CI = null

mob/verb
   Start_Combat_Test()
      if(src.CI) return

      var/Combat_Instance/local_CI = new()
      local_CI.Add_Mob_To_Fight(src, teamID = 1)

      var/mob/player/M = new(src.loc)
      local_CI.Add_Mob_To_Fight(M, teamID = 2)


Combat_Instance/var
   list/teams = list(list(), list(), list())
   list/turn_order = list()
   current_turn = 1
   area/combatArea/our_combat_area
   combat_started = FALSE
   timer_is_on = FALSE
   mob/current_mob

*/
mob
   verb
      Start_Combat_Test()
         if(ci) return  // If we're already in combat

         new/combat_instance(src)


var/list/combat_instance/combat_manager = list()

// A combat instance will be created when a battle begins and deleted when the fight is over
combat_instance
   var
      battle_type = "wild" // Wild pokemon by default. This can become "trainer" or...
      list/mob/combatants = list()  // List of combatants

combat_instance
   New(mob/fight_starter, mob/enemy)
      . = ..()
      combatants.Add(fight_starter)
      combatants.Add(enemy)

      InitializeCombat()
      combat_manager.Add(src)

combat_instance
   proc
      InitializeCombat()
         for(var/mob/combatant in combatants)
            if(combatant && combatant.client) 
               combatant.client.UpdateClientState(IN_BATTLE)
               // Animation players here
         
               // Add battle background to screen
               //combatant.client.vis_contents_map["battle_background"].ToggleMenu(combatant.client)
               combatant.client.interface_overlay.vis_contents.Add(combatant.client.vis_contents_map["battle_background"])
               //C.interface_overlay.vis_contents.Remove(C.vis_contents_map["cursor"])
         
         sleep(30)   // Delay to allow the fade animation to finish. Adjust as needed




         // Fade in
         // Add dialogue box to screen
         // When dialogue interaction is done, leave it blank on the screen
         // Animate in player sprite
         // Send out their first Pokemon
         // Animate it, then Squirtle appears

         // END OF INITIALIZE. Normal combat mechanics begin after this



// Code for the main menu (what you see when you press start)
obj/hud/menu/battle_background
	icon_state = "battle_background"
	pixel_x = 16
	pixel_y = 9
	New(loc)
		. = ..()