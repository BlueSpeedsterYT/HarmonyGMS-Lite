/// @function player_is_sprung(phase)
function player_is_sprung(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Detach from ground
			player_ground(undefined);
            break;
		}
		case PHASE.STEP:
		{
			// Trick
			if (state_time != 0) state_time--;
			if (player_try_trick()) return true;
			
			// Accelerate
			if (input_axis_x != 0)
			{
				image_xscale = input_axis_x;
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
				y_speed = min(y_speed + gravity_force, gravity_cap);
			}
			
			// Animate
			switch (animation_data.index)
			{
				case PLAYER_ANIMATION.SPRING:
				{
					switch (animation_data.variant)
					{
						case 0:
						{
							if (y_speed > 0) animation_data.variant = 1;
							break;
						}
						case 1:
						{
							if (animation_is_finished()) animation_data.variant = 2;
							break;
						}
					}
					break;
				}
				case PLAYER_ANIMATION.SPRING_TWIRL:
				{
					if (animation_is_finished()) animation_init(PLAYER_ANIMATION.SPRING, 2);
					break;
				}
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_dashing(phase)
function player_is_dashing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Detach from ground
			player_ground(undefined);
            
            // Animate 
            animation_init(PLAYER_ANIMATION.DASH);
            break;
		}
		case PHASE.STEP:
		{
			// Trick
			if (state_time != 0) state_time--;
			if (player_try_trick()) return true;
			
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
				y_speed = min(y_speed + gravity_force, gravity_cap);
			}
			
			// Animate
			if (animation_data.index == PLAYER_ANIMATION.DASH and animation_data.variant == 0)
			{
				if (y_speed > 0) animation_data.variant++;
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

// NOTE: Research more into how Sonic Advance 2 handles this. BADLY.
/// @function player_is_corkscrewing(phase)
function player_is_corkscrewing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
            // No animation set here cuz that's handled by the corkscrew object
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;
			
			// Accelerate
			if (input_axis_x != 0)
			{
				image_xscale = input_axis_x;
				if (abs(x_speed) < speed_cap or sign(x_speed) != input_axis_x)
				{
					x_speed += acceleration * input_axis_x;
					if (abs(x_speed) > speed_cap and sign(x_speed) == input_axis_x)
					{
						x_speed = speed_cap * input_axis_x;
					}
				}
			}
			else
			{
				if (abs(x_speed) > 0)
				{
					x_speed += deceleration * input_axis_x;
				}
			}
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Roll
			if (player_try_roll()) return true;
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}