/*
Handles the central loop that happens in our world. Prevents infinitely spawning obj loops.

If you're on the beta version of DM you can use Tick() instead.
*/

proc
   World_Loop_Singleton()
      while(1)
         for(var/mob/player/p in moving_players)
            if(p.client) p.client.Player_Movement_Loop()

         sleep(world.tick_lag)