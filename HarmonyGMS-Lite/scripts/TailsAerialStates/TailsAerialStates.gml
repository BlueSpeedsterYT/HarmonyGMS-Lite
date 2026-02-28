/// @function tails_is_flying(phase)
function tails_is_flying(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Fly
			fly_state_time = 0;
			fly_force = TAILS_FLY_BASE_FORCE;
			
			// Detach from ground
			player_ground(undefined);
			
			// Animate
			animation_play(TAILS_ANIMATION.FLYING);
			break;
		}
		case PHASE.STEP:
		{
			// Accelerate
			if (input_axis_x != 0)
			{
				if (image_xscale != input_axis_x and fly_time < TAILS_FLY_DURATION) animation_play(TAILS_ANIMATION.FLYING_TURN);
				image_xscale = input_axis_x;
				if (abs(x_speed) < speed_limit or sign(x_speed) != input_axis_x)
				{
					x_speed += air_acceleration * input_axis_x;
					if (abs(x_speed) > speed_limit and sign(x_speed) == input_axis_x)
					{
						x_speed = speed_limit * input_axis_x;
					}
				}
			}
			
			if (abs(x_speed) > speed_cap) x_speed = speed_cap * sign(x_speed);
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
			
			// Ascend
			if (input_button.jump.pressed and fly_time < TAILS_FLY_DURATION and y_speed >= TAILS_FLY_THRESHOLD)
			{
				fly_state_time = 60;
				fly_force = -TAILS_FLY_ASCEND_FORCE;
			}
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
			{
				x_speed *= AIR_DRAG;
			}
			
			// Fall
			y_speed += fly_force;
			
			// Reset
			if (y_speed < TAILS_FLY_THRESHOLD or fly_state_time == 0)
			{
				fly_force = TAILS_FLY_BASE_FORCE;
			}
			
			if (y < 0 and y_speed < 0)
			{
				y_speed = 0;
			}
			
			// Timers
			fly_time = min(++fly_time, TAILS_FLY_DURATION);
			fly_state_time = max(--fly_state_time, 0);
			
			// Animate
			if (fly_time < TAILS_FLY_DURATION)
			{
	            if (animation_data.index != TAILS_ANIMATION.FLYING_TURN or animation_is_finished())
	            {
	            	animation_play(TAILS_ANIMATION.FLYING);
	            }
				
				if (not audio_is_playing(sfxTailsFlying))
				{
					audio_stop_sound(fly_sound);
					fly_sound = sound_play(sfxTailsFlying);
				}
			}
			else
			{
				animation_play(TAILS_ANIMATION.FLYING_TIRED);
				audio_stop_sound(fly_sound);
			}
			
			break;
		}
		case PHASE.EXIT:
		{
			// Stop the sound
			audio_stop_sound(fly_sound);
			break;
		}
	}
}