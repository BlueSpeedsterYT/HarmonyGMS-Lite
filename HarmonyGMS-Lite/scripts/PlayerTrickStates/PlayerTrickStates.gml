/// @function player_is_trick_preparing(phase)
function player_is_trick_preparing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Stop
			x_speed = 0;
			y_speed = 0;
			
			// Animate
			switch (trick_index)
			{
				case TRICK_TYPE.UP:
				{
					animation_init(PLAYER_ANIMATION.TRICK_UP);
					break;
				}
				case TRICK_TYPE.DOWN:
				{
					animation_init(PLAYER_ANIMATION.TRICK_DOWN);
					break;
				}
				case TRICK_TYPE.FRONT:
				{
					animation_init(PLAYER_ANIMATION.TRICK_FRONT);
					break;
				}
				default:
				{
					animation_init(PLAYER_ANIMATION.TRICK_BACK);
					break;
				}
			}
			break;
		}
		case PHASE.STEP:
		{
			// Trick
			if (animation_is_finished())
			{
				if ((object_index == objSonic or object_index == objKnuckles) and trick_index == TRICK_TYPE.DOWN)
				{
					switch (object_index)
					{
						case objSonic:
						{
							y_speed = 2;
							return player_perform(sonic_is_preparing_bound, false);
						}
						
						case objKnuckles:
						{
							y_speed = 1;
							return player_perform(knuckles_is_preparing_drill_clawing, false);
						}
					}
				}
				else
				{
					x_speed = image_xscale * trick_speed[trick_index][0];
					y_speed = trick_speed[trick_index][1];
					return player_perform(player_is_tricking);
				}
			}
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_tricking(phase)
function player_is_tricking(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set time:
			if ((object_index == objSonic) and trick_index == TRICK_TYPE.FRONT) state_time = 45;
			else if (object_index == objKnuckles and (trick_index == TRICK_TYPE.FRONT or trick_index == TRICK_TYPE.BACK)) state_time = 10;
            else state_time = 0;
			
			// Animate
            animation_data.variant++;
            break;
		}
		case PHASE.STEP:
		{
			if (state_time != 0) state_time--;
			if ((object_index == objSonic) and trick_index == TRICK_TYPE.FRONT and state_time == 0) animation_init(PLAYER_ANIMATION.FALL);
			
			var trick_spiral = (object_index == objKnuckles and trick_index == TRICK_TYPE.UP);
			var trick_glide = (object_index == objKnuckles and (trick_index == TRICK_TYPE.FRONT or trick_index == TRICK_TYPE.BACK) and state_time > 0);
			
			// Accelerate
			if (not trick_spiral or y_speed > 0)
			{
				if (input_axis_x != 0)
				{
					if (abs(x_speed) < speed_cap or sign(x_speed) != input_axis_x)
					{
						x_speed += air_acceleration * input_axis_x;
						if (abs(x_speed) > speed_cap and sign(x_speed) == input_axis_x)
						{
							x_speed = speed_cap * input_axis_x;
						}
					}
				}
			}
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground)
            {
                if (object_index == objKnuckles and trick_index == TRICK_TYPE.FRONT) return player_perform(knuckles_is_somersaulting);
                return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            }
			
			if (not trick_glide)
			{
				// Apply air resistance
				if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
				{
					x_speed *= AIR_DRAG;
				}
				
				// Fall
				if (y_speed < gravity_cap)
				{
					var trick_force = gravity_force;
                    var trick_float = ((object_index == objTails) and (trick_index == TRICK_TYPE.FRONT or trick_index == TRICK_TYPE.BACK) and y_speed < 0);
                    if (trick_float) trick_force /= 2;
                    y_speed = min(y_speed + trick_force, gravity_cap);
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