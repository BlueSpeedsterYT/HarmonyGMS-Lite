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
			
			// Animate
			animation_init(PLAYER_ANIMATION.FLYING);
			break;
		}
		case PHASE.STEP:
		{
			// Decrease timer
			if (fly_time > 0)
			{
				--fly_time;
			}
			
			// Set up flight system
			if (fly_force_time != 1)
			{
				if (y_speed >= TAILS_FLY_THRESHOLD)
				{
					fly_force = -TAILS_FLY_ASCEND_FORCE;
					if (++fly_force_time == 32)
					{
						fly_force_time = 1;
					}
				}
				else
				{
					fly_force_time = 1;
				}
			}
			else
			{
				// Fly Upwards
				if (input_button.jump.pressed and fly_time and y_speed >= TAILS_FLY_THRESHOLD)
				{
					fly_force_time = 2;
				}
				
				fly_force = TAILS_FLY_BASE_FORCE;
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
			
			// Reset when at the top
			var top = objCamera.bound_top;
			if (y < top)
			{
				y = top;
				if (y_speed < 0) y_speed = 0;
			}
			
			// Change animations accordingly depending on the current flight time remaining
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
				
				// Play the sound
				if (not audio_is_playing(sfxTailsFlying))
				{
					audio_stop_sound(fly_sound);
					fly_sound = sound_play(sfxTailsFlying);
				}
			}
			else
			{
				// Tire out
				animation_init(PLAYER_ANIMATION.FLYING_TIRED);
				
				// Stop the sound
				if (audio_is_playing(fly_sound))
				{
					audio_stop_sound(fly_sound);
				}
			}
			
			break;
		}
		case PHASE.EXIT:
		{
			// Stop the sound
			if (audio_is_playing(fly_sound))
			{
				audio_stop_sound(fly_sound);
			}
			break;
		}
	}
}