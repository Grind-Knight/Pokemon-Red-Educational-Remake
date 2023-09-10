mob/player
   Login()
      . = ..()
      players_in_world += src
      //loc = locate(101, 146, 1)
      loc = locate(218, 340, 1)  //testing loc for fence jumping
mob/player
   Logout()
      . = ..()
      players_in_world -= src