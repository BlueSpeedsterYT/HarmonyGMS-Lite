/// @function player_is_falling(phase)
function player_is_falling(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
            if (not (aerial_flags & AERIAL_FLAG.PLATFORM))
            {
                // Rise
                y_speed = -dsin(local_direction) * x_speed;
                x_speed *= dcos(local_direction);
            }
			
			// Detach from ground
			player_ground(undefined);
			
			// Animate
			animation_play(PLAYER_ANIMATION.FALL, 0, [PLAYER_ANIMATION.RUN, PLAYER_ANIMATION.ROLL]);
			break;
		}
		case PHASE.STEP:
		{
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
			break;
		}
		case PHASE.EXIT:
		{
			aerial_flags &= ~AERIAL_FLAG.PLATFORM;
			break;
		}
	}
}

/// @function player_is_jumping(phase)
function player_is_jumping(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set flags
			jump_cap = true;
			
			// Leap
			var sine = dsin(local_direction);
			var cosine = dcos(local_direction);
			y_speed = -sine * x_speed - cosine * jump_height;
			x_speed = cosine * x_speed - sine * jump_height;
			
			// Detach from ground
			player_ground(undefined);
			
			// Animate
			animation_play(PLAYER_ANIMATION.JUMP, 0);
			break;
		}
		case PHASE.STEP:
		{
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
			
			// Skill
			if (player_try_skill()) exit;
			
			// Lower height
			if (jump_cap and y_speed < -jump_release and not input_button.jump.check)
			{
				y_speed = -jump_release;
			}
			
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
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_hurt(phase)
function player_is_hurt(phase)
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
			// Move
			player_move_in_air();
			if (state_changed) exit;
            
            // Land
			if (on_ground) return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
            
            // Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + recoil_gravity, gravity_cap);
			}
            break;
		}
		case PHASE.EXIT:
		{
			recovery_time = RECOVERY_DURATION;
            break;
		}
	}
}

/// @function player_is_dead(phase)
function player_is_dead(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Detach from ground
			player_ground(undefined);
			
			// Animate
			animation_play(PLAYER_ANIMATION.DEAD);
			break;
		}
		case PHASE.STEP:
		{
			// Move
			var sine = dsin(gravity_direction);
			var cosine = dcos(gravity_direction);
            x += sine * y_speed;
            y += cosine * y_speed;
			
			// Lock up
			var y_int = y div 1;
			var cam_y = camera_get_view_y(CAMERA_ID);
			if (y_int >= cam_y + (CAMERA_HEIGHT + 80) - 1)
			{
				return player_handle_death();
			}
			else
			{
				// Fall
				if (y_speed < gravity_cap)
				{
					y_speed = min(y_speed + gravity_force, gravity_cap);
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

/// @function player_is_debugging(phase)
function player_is_debugging(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Reset Speed
			x_speed = 0;
			y_speed = 0;
			
			// Detach from ground
			player_ground(undefined);
			break;
		}
		case PHASE.STEP:
		{
			// Fly around, whilst staying within bounds
			x += input_axis_x * 8;
			y += input_axis_y * 8;
			player_in_camera_bounds();
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}