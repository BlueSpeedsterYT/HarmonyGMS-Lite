/// @function knuckles_is_landing(phase)
function knuckles_is_landing(phase)
{
	switch(phase)
	{
		case PHASE.ENTER:
		{
			// Stop
			x_speed = 0;
			
			// Animate
			animation_init(PLAYER_ANIMATION.GLIDE_FALL, 1);
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;

		    // Move
			player_move_on_ground();
			if (state_changed) exit;

		    // Fall
			if (not on_ground or (local_direction >= 90 and local_direction <= 270))
			{
				return player_perform(knuckles_is_falling);
			}

		    // Slide down steep slopes
			if (local_direction >= 45 and local_direction <= 315)
			{
				control_lock_time = SLIDE_DURATION;
				return player_perform(player_is_running);
			}

		    // Run
            if (x_speed != 0)
            {
                return player_perform(player_is_running);
            }

		    // Stand
			if (animation_is_finished())
            {
                return player_perform(player_is_standing);
            }
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function knuckles_is_sliding(phase)
function knuckles_is_sliding(phase)
{
	switch(phase)
	{
		case PHASE.ENTER:
		{
			// Slide off
			x_speed = (x_speed * dcos(direction)) - (y_speed * dsin(direction));
			
			// Animate
			animation_init(PLAYER_ANIMATION.GLIDE_SLIDING);
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;

		    // Friction
			x_speed -= min(abs(x_speed), knuckles_glide_slide_friction) * sign(x_speed);
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;

		    // Fall
			if (not on_ground or (local_direction >= 90 and local_direction <= 270))
			{
				return player_perform(knuckles_is_falling);
			}

		    // Slide down steep slopes
			if (abs(x_speed) < SLIDE_THRESHOLD)
			{
				if (local_direction >= 90 and local_direction <= 270)
				{
					return player_perform(knuckles_is_falling);
				}
				else if (local_direction >= 45 and local_direction <= 315)
				{
					control_lock_time = SLIDE_DURATION;
					return player_perform(player_is_running)
				}
			}

		    // Stand
            if (x_speed == 0)
            {
                // NOTE: In Advance 2, Knuckles lacks an animation for standing up from a glide
				// as such, his ass just *IMMEDIATELY* goes straight into the player idle state.
				// ... i ported the Glide Standing state from SonicForGMS for no reason.
				return player_perform(player_is_standing);
            }

		    // Create brake dust
			if (animation_data.time mod 4 == 0)
			{
				var ox = x + dsin(direction) * y_radius;
				var oy = y + dcos(direction) * y_radius;
				particle_create(ox, oy, global.ani_brake_dust_v0);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}