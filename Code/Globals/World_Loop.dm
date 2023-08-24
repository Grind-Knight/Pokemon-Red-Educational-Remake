/*
Handles the central loop that happens in our world. Prevents infinitely spawning obj loops.
*/

proc
   World_Loop_Singleton()
      while(1)

         for(var/mob/player/p in moving_players)
            if(p.client)
               //if(moving_players[p] == TRUE)
               p.client.Player_Movement_Loop()

         sleep(world.tick_lag)