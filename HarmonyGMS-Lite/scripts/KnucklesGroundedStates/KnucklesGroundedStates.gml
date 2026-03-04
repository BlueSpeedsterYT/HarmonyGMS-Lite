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
			animation_play(KNUCKLES_ANIMATION.GLIDE_FALL, 1);
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
			if (mask_direction != gravity_direction)
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
			animation_play(KNUCKLES_ANIMATION.GLIDE_SLIDING);
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump()) return true;

		    // Friction
			x_speed -= min(abs(x_speed), KNUCKLES_GLIDE_SLIDE_FRICTION) * sign(x_speed);
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;

		    // Fall
			if (not on_ground or (local_direction >= 90 and local_direction <= 270))
			{
				return player_perform(knuckles_is_falling);
			}

		    // Slide down steep slopes
			if (abs(x_speed) < SLIDE_THRESHOLD and mask_direction != gravity_direction)
			{
				if (local_direction >= 90 and local_direction <= 270)
				{
					return player_perform(knuckles_is_falling);
				}
				else
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

/// @function knuckles_is_punching_left(phase)
function knuckles_is_punching_left(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set speed
			if (abs(x_speed) < 3)
			{
				x_speed = image_xscale * 3;
			}
			
			// Animate
			animation_play(KNUCKLES_ANIMATION.PUNCH, 0);
			break;
		}
		case PHASE.STEP:
		{
			// Friction
			x_speed -= min(abs(x_speed), 0.375) * sign(x_speed);
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Slide down steep slopes
			if (mask_direction != gravity_direction)
			{
				control_lock_time = SLIDE_DURATION;
				return player_perform(player_is_running);
			}
			
			// Update
			if ((animation_data.index == KNUCKLES_ANIMATION.PUNCH and animation_data.variant == 0) and animation_is_finished())
			{
				if (on_ground)
				{
					return player_perform(knuckles_is_punching_right);
				}
				else
				{
					player_ground(undefined);
					animation_play(PLAYER_ANIMATION.ROLL);
					return player_perform(player_is_falling);
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

/// @function knuckles_is_punching_right(phase)
function knuckles_is_punching_right(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set speed
			if (abs(x_speed) < 3)
			{
				x_speed = image_xscale * 3;
			}
			
			// Animate
			animation_play(KNUCKLES_ANIMATION.PUNCH, 1);
			break;
		}
		case PHASE.STEP:
		{
			// Friction
			x_speed -= min(abs(x_speed), 0.375) * sign(x_speed);
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Update
			if ((animation_data.index == KNUCKLES_ANIMATION.PUNCH and animation_data.variant == 1) and animation_is_finished())
			{
				if (on_ground)
				{
					return player_perform(player_is_standing);
				}
				else
				{
					player_ground(undefined);
					animation_play(PLAYER_ANIMATION.ROLL);
					return player_perform(player_is_falling);
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

/// @function knuckles_is_sprial_attack(phase)
function knuckles_is_sprial_attack(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set flags
			state_time = 32;
			
			// Animate
			animation_play(KNUCKLES_ANIMATION.SPIRAL_ATTACK, 0);
			break;
		}
		case PHASE.STEP:
		{
			// Friction
			x_speed -= min(0, deceleration / 2) * sign(x_speed);
			
			// Move
			player_move_on_ground();
			if (state_changed) exit;
			
			// Reset speed
			if ((local_direction + 90) & (358.59375) >= 180)
			{
				x_speed = 0;
			}
			
			// Animate
			if (--state_time == -1)
			{
				if (animation_is_matching(KNUCKLES_ANIMATION.SPIRAL_ATTACK, 0))
				{
					animation_data.variant++;
				}
				else if (animation_is_matching(KNUCKLES_ANIMATION.SPIRAL_ATTACK, 1) and animation_is_finished())
				{
					if (on_ground)
					{
						return player_perform(player_is_standing);
					}
					else
					{
						player_ground(undefined);
						return player_perform(player_is_falling);
					}
				}
			}
			break;
		}
		case PHASE.EXIT:
		{
			state_time = 0;
			break;
		}
	}
}