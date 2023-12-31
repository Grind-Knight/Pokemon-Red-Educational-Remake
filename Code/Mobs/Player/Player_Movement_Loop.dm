mob
	var
		tmp/walking_speed = 4 // Adjust this value to control the walking speed

client
	var
		tmp/movement_counter = 0

mob
	verb
		Change_Speed(n as num)
			walking_speed = n

mob
	proc
		CanMove()
			if(!flags[TELEPORT_FLAG] && client.client_state == IN_GAME) return TRUE
			else return FALSE

client
	proc
		Player_Movement_Loop()	// Called once every world tick.
			if(movement_counter > 0) movement_counter--

			// Determine the movement direction based on the queued direction or the keys being held down
			var d = mob.queued_direction ? mob.queued_direction : mob.next_move

			// If there's a direction to move and the counter has reached 0, move in that direction
			if(d && movement_counter == 0)
				mob.glide_size = world.icon_size / mob.walking_speed

				// Reset the movement counter to introduce delay
				movement_counter = mob.walking_speed

				if(mob.CanMove()) step(mob, d)
				
				// Reset the queued direction after moving
				mob.queued_direction = 0