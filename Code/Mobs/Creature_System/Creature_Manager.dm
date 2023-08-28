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
      name
      nickname
      number = 0
      evolves_to
      evolution_condition
      experience_rate = 1
      list/leveled_moves = list("move_name" = 10)  //move_name = level we learn it at
      list/compatible_tm = list()
      list/compatible_hm = list()
      list/creature_types = list("Fire", "Flying")

      // Stats
      level
      health
      attack
      defense
      special
      speed

creature
   proc
      TotalStats()
         return health + attack + defense + special + speed