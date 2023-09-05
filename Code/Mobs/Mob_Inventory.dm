/*
All mobs can have an inventory. However, only players will be given a HUD to display their items in.
*/

mob
   var
      list/item_slot/inventory = list()

mob
   New(loc)
      . = ..()
      for(var/i = 0; i < INVENTORY_SIZE_LIMIT; i++)
         inventory += new/item_slot

mob
   proc
      FindExistingOrEmptySlot(item/I)
         for(var/item_slot/slot in inventory)
            // Check if the slot contains the same item and can store more of it
            if(slot.stored_item == I && slot.quantity < I.stack_limit)
               return slot
            
            // Check for an empty slot
            if(!slot.stored_item)
               return slot

         // If we reach here, there's no free slot and no existing slot we can add to
         return null
