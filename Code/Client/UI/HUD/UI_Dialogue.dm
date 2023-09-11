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
   New()
      . = ..()
      var/obj/hud/button/ic = new()
      ic.parent_menu = src
      ic.cursor_style = "down"
      ic.button_id = 1
      ic.pixel_x = 162
      ic.pixel_y = 20
      menu_items += ic
