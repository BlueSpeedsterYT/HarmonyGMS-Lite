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
				return player_perform(player_is_bounding);
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

/// @function player_is_bounding(phase)
function player_is_bounding(phase)
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
				if (object_index == objSonic) sound_play(sfxSonicBoundAttack);
				return player_perform(player_is_rebounding);
			}
			
			// Apply air resistance
			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
			{
				x_speed *= AIR_DRAG;
			}
			
			// Fall
			if (y_speed < gravity_cap)
			{
				y_speed = min(y_speed + sonic_bound_force, gravity_cap);
			}
			
			// Create bound effect
			if (animation_data.time mod 2 == 0)
			{
				particle_create(x div 1, y div 1, global.ani_sonic_trick_down_v2, 0, 0, 0, 0, depth + 10);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function player_is_rebounding(phase)
function player_is_rebounding(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Rebound
			var sine = dsin(local_direction);
			var cosine = dcos(local_direction);
			y_speed = -cosine * sonic_bound_height;
			x_speed = -sine * sonic_bound_height / 2;
			
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
				y_speed = min(y_speed + sonic_bound_force, gravity_cap);
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