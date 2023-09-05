/* 
This file should contain everything that happens on World/New(). 
*/ 

world
   New()
      . = ..()
      spawn() World_Loop_Singleton()  //Start our global loop to handle everything.

      im_singleton = new
      im_singleton.PopulateItems()

      cm_singleton = new
      cm_singleton.PopulateCreatures()