mob
	var
		walking_speed = 4 // Adjust this value to control the walking speed
	step_size = 16

client
	var
		tmp
			movement_counter = 0

mob
	verb
		Change_Speed(n as num)
			walking_speed = n

client
	proc
		Player_Movement_Loop()
			// If the counter is greater than 0, decrease it.
			if(movement_counter > 0)
				movement_counter--

			// Determine the movement direction based on the queued direction or the keys being held down
			var d = src.mob.queued_direction ? src.mob.queued_direction : src.mob.next_move

			// If there's a direction to move and the counter has reached 0, move in that direction
			if(d && movement_counter == 0)
				mob.glide_size = world.icon_size / mob.walking_speed

				// Reset the movement counter to introduce delay
				movement_counter = src.mob.walking_speed
				step(src.mob, d)
				// Reset the queued direction after moving
				src.mob.queued_direction = 0