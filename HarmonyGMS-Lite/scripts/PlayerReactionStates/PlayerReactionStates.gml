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
			if (player_try_trick_action(state_time)) exit;
			
			// Accelerate
			if (input_axis_x != 0)
			{
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
			
			// Apply air resistance
			player_resist_air();
			
			// Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + gravity_force, gravity_cap);
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
            animation_play(PLAYER_ANIMATION.DASH);
            break;
		}
		case PHASE.STEP:
		{
			// Trick
			if (state_time != 0) state_time--;
			if (player_try_trick_action(state_time)) exit;
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
			
			// Apply air resistance
			player_resist_air(64);
			
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
			if (player_try_jump()) exit;
			
			// Accelerate
			if (input_axis_x != 0)
			{
				image_xscale = input_axis_x;
				if (abs(x_speed) < speed_limit or sign(x_speed) != input_axis_x)
				{
					x_speed += acceleration * input_axis_x;
					if (abs(x_speed) > speed_limit and sign(x_speed) == input_axis_x)
					{
						x_speed = speed_limit * input_axis_x;
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
			
			if (abs(x_speed) > speed_cap) x_speed = speed_cap * sign(x_speed);
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Crouch or Roll
			if (player_try_crouch_or_roll()) exit;
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}