/* 
This file should contain everything that happens on World/New(). 
*/ 

world
   New()
      . = ..()
      spawn() World_Loop_Singleton()  //Start our global loop to handle everything.
