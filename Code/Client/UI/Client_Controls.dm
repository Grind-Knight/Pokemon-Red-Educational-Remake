/*
Setup client controls here. Specific for clients only, not all mobs. Obiously!
*/

client
   New()
      ..()
      //So we know these keys are false by default rather than null.
      //Otherwise the movement loop runs until we tap each key once and set it to false.
      keys["W"] = FALSE
      keys["A"] = FALSE
      keys["S"] = FALSE
      keys["D"] = FALSE
      
      winset(src, "macro_down", "parent=macro;name=Any;command=KeyDown+\[\[*]]")
      winset(src, "macro_up", "parent=macro;name=Any+UP;command=KeyUp+\[\[*]]")
      focus = mob
      if(!(mob in moving_players)) moving_players += mob
      
client
   var
      keys[] = new
      datum/focus
      is_moving = FALSE

client
   verb
      KeyDown(key as text)
         set waitfor = FALSE
         set hidden = TRUE
         set instant = TRUE
         keys[key] = TRUE
         focus:KeyDown(key, src)
         if(key in list("W", "A", "S", "D"))
            if(!moving_players[mob]) moving_players[mob] = TRUE

client
   verb
      KeyUp(key as text)
         set waitfor = FALSE
         set hidden = TRUE
         set instant = TRUE
         keys[key] = FALSE
         focus:KeyUp(key, src)

         if(keys["W"] == FALSE && keys["A"] == FALSE && keys["S"] == FALSE && keys["D"] == FALSE)
            moving_players[mob] = FALSE

datum
   proc
      KeyDown(key, client/c)
      KeyUp(key, client/c)

//Below is setting up the actual controls for the keys.
mob
   var
      next_move = 0 // Variable to store the current movement direction
      queued_direction = 0 // Variable to store the queued movement direction

client
   var
      tmp
         key_pressed = FALSE // Variable to track when a key is pressed
         last_key = null // Variable to track the last movement key pressed

mob
   KeyDown(key, client/c)
      switch(key)
         if("W", "A", "S", "D")
            switch(c.client_state)
               if(IN_GAME)
                  // Determine the direction based on the key pressed
                  var new_direction = key == "W" ? NORTH : key == "D" ? EAST : key == "S" ? SOUTH : key == "A" ? WEST : 0
                  
                  // If no other movement keys are being held down, set the queued direction
                  if(!(c.keys["W"] || c.keys["A"] || c.keys["S"] || c.keys["D"])) queued_direction = new_direction
                  
                  // Set the next movement direction
                  next_move = new_direction
               if(IN_MENU)
                  switch(key)
                     if("W", "A")
                        c.CursorMove(NORTH)
                     if("S", "D")
                        c.CursorMove(SOUTH)

         if("Escape")
            client.StartButton()
         
         if("Tab")
            client.SelectButton()

         if("Space")
            client.InteractButton()
         
         if("V")
            client.BackButton()


mob
   KeyUp(key, client/c)
      switch(key)
         if("W", "A", "S", "D")
            // Determine the new movement direction based on the remaining keys being held down
            next_move = c.keys["W"] ? NORTH : c.keys["D"] ? EAST : c.keys["S"] ? SOUTH : c.keys["A"] ? WEST : 0
