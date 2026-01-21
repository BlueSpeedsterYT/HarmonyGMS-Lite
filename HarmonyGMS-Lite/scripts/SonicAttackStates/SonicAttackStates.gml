/// @function sonic_is_skidding(phase)
function sonic_is_skidding(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Set variables
			x_speed = 3 * image_xscale;
			
			// Play sound
			sound_play(sfxSwipe);
			
			// Animate
			animation_init(SONIC_ANIMATION.SKIDDING, 0);
			break;
		}
		case PHASE.STEP:
		{
			if (on_ground)
			{
				// Friction
				var is_skidding_anim = (animation_data.index == SONIC_ANIMATION.SKIDDING and animation_data.variant == 1);
				var friction_value = is_skidding_anim ? 0.125 : acceleration;
				x_speed -= min(abs(x_speed), friction_value) * sign(x_speed);
				
				// Move
				player_move_on_ground();
				if (state_changed) exit;
				
				// Get off ground
				if (not on_ground) return player_ground(undefined);
			
				// Slide down steep slopes
				if (abs(x_speed) < SLIDE_THRESHOLD and local_direction >= 90 and local_direction <= 270)
				{
					return player_perform(player_is_falling);
				}
				else if ((x_speed != 0 and sign(x_speed) != image_xscale) or (local_direction >= 45 and local_direction <= 315))
				{
					control_lock_time = SLIDE_DURATION;
					return player_perform(player_is_running);
				}
				
				// Update
				if (animation_data.index == SONIC_ANIMATION.SKIDDING and animation_is_finished())
				{
					switch (animation_data.variant)
					{
						case 0:
						{
							animation_data.variant++;
							sound_play(sfxSliding);
							x_speed = 4 * image_xscale;
							state_time = 33;
							break;
						}
						
						case 2:
						{
							return player_perform(player_is_standing);
							break;
						}
					}
				}
			}
			else
			{
				// We're not in the ground doing the animation so
				// reset to the falling state immediately.
				animation_init(PLAYER_ANIMATION.ROLL);
				return player_perform(player_is_falling);
			}
			
			// Do Skidding related stuff...
			if (animation_data.index == SONIC_ANIMATION.SKIDDING and animation_data.variant == 1)
			{
				// Create brake dust
				if (animation_data.time mod 4 == 0)
				{
					if (not on_ground) exit;
					var ox = x + dsin(direction) * y_radius;
					var oy = y + dcos(direction) * y_radius;
					particle_create(ox, oy, global.ani_brake_dust_v0);
				}
				
				// Finish off the skidding
				if (state_time-- == 0)
				{
					if (on_ground)
					{
						animation_data.variant++;
					}
					else
					{
						player_ground(undefined);
						animation_init(PLAYER_ANIMATION.ROLL);
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
};

/// @function sonic_is_preparing_bound(phase)
function sonic_is_preparing_bound(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Stop
			x_speed = 0;
			y_speed = 0;
			
			// Animate
			animation_init(PLAYER_ANIMATION.TRICK_DOWN);
			break;
		}
		case PHASE.STEP:
		{
			// Trick
			if (animation_is_finished())
			{
				y_speed = 2;
				return player_perform(sonic_is_bounding);
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

/// @function sonic_is_bounding(phase)
function sonic_is_bounding(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Animate
            animation_data.variant++;
            break;
		}
		case PHASE.STEP:
		{
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Rebound
			if (on_ground) 
			{
				sound_play(sfxSonicBoundAttack);
				return player_perform(sonic_is_rebounding);
			}
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
			{
				x_speed *= AIR_DRAG;
			}
			
			// Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + SONIC_BOUND_FORCE, gravity_cap);
			}
			
			// Create bound effect
			if (animation_data.time mod 2 == 0)
			{
				var ox = x div 1;
				var oy = y div 1;
				particle_create(ox, oy, global.ani_sonic_trick_down_v2, , , , , , , 10);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function sonic_is_rebounding(phase)
function sonic_is_rebounding(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Rebound
			var sine = dsin(local_direction);
			var cosine = dcos(local_direction);
			y_speed = -cosine * SONIC_BOUND_HEIGHT;
			x_speed = -sine * SONIC_BOUND_HEIGHT / 2;
			
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
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
			{
				x_speed *= AIR_DRAG;
			}
			
			// Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + SONIC_BOUND_FORCE, gravity_cap);
			}
			
			if (y_speed > 0)
			{
				animation_data.variant++;
				return player_perform(player_is_falling, false);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}