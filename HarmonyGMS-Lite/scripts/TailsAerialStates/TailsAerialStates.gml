/// @function tails_is_flying(phase)
function tails_is_flying(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Rise
			y_speed = -dsin(local_direction) * x_speed;
			x_speed *= dcos(local_direction);
			
			// Detach from ground
			player_ground(undefined);
			
			// Give base flight force
			fly_force = tails_fly_base_force;
			
			// Animate
			animation_init(PLAYER_ANIMATION.FLYING);
			break;
		}
		case PHASE.STEP:
		{
			// Fly Upwards
			if (input_button.jump.pressed and fly_time and y_speed >= tails_fly_threshold)
			{
				fly_force = -tails_fly_ascend_force;
			}
			
			// Accelerate
			if (input_axis_x != 0)
			{
				if (not fly_time) image_xscale = input_axis_x;
				if (abs(x_speed) < speed_cap or sign(x_speed) != input_axis_x)
				{
					x_speed += air_acceleration * input_axis_x;
					if (abs(x_speed) > speed_cap and sign(x_speed) == input_axis_x)
					{
						x_speed = speed_cap * input_axis_x;
					}
				}
			}
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
			{
				x_speed *= AIR_DRAG;
			}
			
			// Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + fly_force, gravity_cap);
			}
			
			// Cap out if the Y speed is over the threshold
			if (y_speed < tails_fly_threshold)
			{
				fly_force = tails_fly_base_force;
			}
			
			// Change animations accordingly depending on the current flight time remaining
			if (fly_time > 0) fly_time--;
			if (fly_time)
			{
				// Turn
	            if (input_axis_x != 0 and image_xscale != input_axis_x)
	            {
	                animation_init(PLAYER_ANIMATION.FLYING_TURN);
	                image_xscale *= -1;
	            }
            
	            if (animation_data.index == PLAYER_ANIMATION.FLYING_TURN and animation_is_finished())
	            {
	            	animation_init(PLAYER_ANIMATION.FLYING);
	            }
			}
			else
			{
				// Tire out
				animation_init(PLAYER_ANIMATION.FLYING_TIRED);
			}
			
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}