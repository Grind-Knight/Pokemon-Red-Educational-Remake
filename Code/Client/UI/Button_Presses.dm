client
   var
      tmp
         client_state = "IN_GAME"

         list/obj/hud/menu_stack = list()

// client
//    proc
//       StartButton()
//          world << "Pressed Start!"
//          switch(current_menu_state)
//             if(null, "Closed")
//                vis_contents_map["main_menu"].OpenMenu()
//                current_menu_state = "Main"
//             if("Main")
//                vis_contents_map["main_menu"].CloseMenu()
//                current_menu_state = "Closed"

client
   Stat()
      . = ..()
      stat("Client State:", client_state)

client
   verb
      Test_Menu_Stack()
         vis_contents_map["main_menu"].OpenMenu()
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
            if("IN_GAME")
               if(!menu_stack.len)
                  vis_contents_map["main_menu"].OpenMenu(src)  // Open the main menu if no menu is open
            if("IN_MENU")
               // in menu stuff
               world << "in menu"

         menu_stack[1].OnButtonPressStart(src)


client
   proc
      SelectButton()
         if(!menu_stack.len) return

         menu_stack[1].OnButtonPressSelect(src)

client
   proc
      InteractButton()
         if(!menu_stack.len) return

         menu_stack[1].OnButtonPressInteract(src)

client
   proc
      BackButton()
         if(!menu_stack.len) return

         menu_stack[1].OnButtonPressBack(src)