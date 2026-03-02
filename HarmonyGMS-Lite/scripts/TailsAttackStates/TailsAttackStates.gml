/// @function tails_is_tail_swipe(phase)
function tails_is_tail_swipe(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Play sound
			sound_play(sfxSwipe);
			
			// Animate
			animation_play(TAILS_ANIMATION.SWIPE, 0);
			break;
		}
		case PHASE.STEP:
		{
			if (on_ground)
			{
				// Friction
				if (x_speed > 0)
				{
					x_speed = max(0, x_speed - (deceleration / 2));
				}
				else
				{
					x_speed = min(0, x_speed + (deceleration / 2));
				}
				
				// Move
				player_move_on_ground();
				if (state_changed) exit;
				
				// Fall
				if (not on_ground)
				{
					y_speed = -dsin(local_direction) * x_speed;
					x_speed *= dcos(local_direction);
					return player_ground(undefined);
				}
				
				// Slide down steep slopes
				if (mask_direction != gravity_direction)
				{
					control_lock_time = SLIDE_DURATION;
					return player_perform(player_is_running);
				}
			}
			else
			{
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
			}
			
			var is_swiping_anim = (animation_data.index == TAILS_ANIMATION.SWIPE or (animation_data.index == TAILS_ANIMATION.SUPER_SWIPE and animation_data.variant == 0))
			if (is_swiping_anim and animation_is_finished())
			{
				if (on_ground)
				{
					return player_perform(x_speed != 0 ? player_is_running : player_is_standing);
				}
				else
				{
					player_ground(undefined);
					animation_play(PLAYER_ANIMATION.SPRING, 2);
					return player_perform(player_is_falling, false);
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