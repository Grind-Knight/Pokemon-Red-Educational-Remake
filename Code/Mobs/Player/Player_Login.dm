mob/player
   Login()
      . = ..()
      players_in_world += src
      loc = locate(101, 146, 1)

mob/player
   Logout()
      . = ..()
      players_in_world -= src