mob/player
   Login()
      . = ..()
      players_in_world += src

mob/player
   Logout()
      . = ..()
      players_in_world -= src