var
   creature_manager/cm_singleton

creature_manager
   var
      list/creatures = list()

creature_manager
   proc
      PopulateCreatures()
         for(var/i in (typesof(/creature) - /creature))
            i = new i
            creatures[i:number] = i

creature
   var
      //CONSTANTS
      name
      number = 000
      evolves_to
      evolution_level
      experience_tier = 3 //1=erratic, 2=fast, 3=medium fast, 4=medium slow, 5=slow, 6=fluctuating
      list/leveled_moves = list()  //(level = "move name")
      list/compatible_tm = list() //we cannot use 08 for a compatible TM; TM08 for example will have to check for 8 in the compatability list
      list/compatible_hm = list()
      list/creature_types = list("Fire", "Flying")

      // Stats
      base_health
      base_attack
      base_defense
      base_special
      base_speed

      level
      nickname

creature
   proc
      TotalStats()
         return base_health + base_attack + base_defense + base_special + base_speed