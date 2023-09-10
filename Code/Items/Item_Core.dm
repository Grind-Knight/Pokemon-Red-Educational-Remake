/*
Core setup for our item system.

The below types are NOT final. I just started to plan out the inheritance system we'll use for the
different item types. They may change later.
*/


item_slot
   var
      item/stored_item
      quantity = 0

// Global singleton for item management
var
   item_manager/im_singleton

item_manager
   var
      list/items = list()


/* This fills our singleton object (im_singleton) with every item in the game.
We can access it by using im_singleton.items[item_name]
Then with this ^ we can access all of the item data. */
item_manager
   proc
      PopulateItems()
         for(var/i in (typesof(/item) - /item))
            i = new i
            items[i:name] = i

mob
   verb
      Give_Item()
         im_singleton.items["potion"].GiveItem(src)

proc
   pad_string_to_length(original, desired_length)
      while(length(original) < desired_length)
         original += " "
      return original

item
   proc
      GiveItem(mob/M)
         var/item_slot/slot = M.FindExistingOrEmptySlot(src)
         if(slot)
            if(!slot.stored_item)
               slot.stored_item = src
            slot.quantity++
            M << "[src.name] added to slot with quantity [slot.quantity]."

            var/padded_name = pad_string_to_length(uppertext("<font size=1>[src.name]"), 33)
            M.client.vis_contents_map["inventory"].menu_items[M.inventory.Find(slot)].maptext = "[padded_name] x[slot.quantity]"
         else
            M << "No suitable slot found for [src.name]."
         if(M.client)
            M.client.vis_contents_map["inventory"].UpdateDisplayedSlots()

item
   proc
      Use()
         world << "Using [src] (no functionality yet)."

item/consumable/potion
   name = "potion"
   //id = 1
   stack_limit = 3
   description = "Heals a single pokemon for 20!"
   heal_amount = 20

// Base Item Type
item
   var
      name
      //id = 0
      stack_limit = 99
      description

// Consumables
item/consumable
   var
      heal_amount
      pp_restore
      status_cure

// Reusable Items
item/reusable
   var
      uses_left = -1  // -1 for infinite uses

// Key Items
item/reusable/key_item
   var
      quest_related  // Boolean to check if it's related to a quest

// Teaching Items (TMs and HMs)
item/teaching_item
   var
      move_taught  // The move that this TM or HM will teach

// TMs
item/consumable/teaching_item/tm
   var
      is_consumable = TRUE  // Explicitly stating it's consumable

// HMs
item/reusable/teaching_item/hm
   var
      is_consumable = FALSE  // Explicitly stating it's not consumable

// Hold Items
item/hold_item
   var
      effect  // Description of the effect when held

// Battle Items
item/battle_item
   var
      battle_effect  // Description or code for the effect in battle

// Evolutionary Items
item/evolution_item
   var
      evolves_pokemon_to  // The creature this item will evolve a Pokémon into
