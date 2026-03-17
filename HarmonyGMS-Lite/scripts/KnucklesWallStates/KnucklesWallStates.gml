/// @function knuckles_is_climbing(phase)
function knuckles_is_climbing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Reset speed
			x_speed = 0;
			y_speed = 0;
			
			// Detach from ground
			player_ground(undefined);
			break;
		}
		case PHASE.STEP:
		{
			// Jump
			if (player_try_jump())
			{
				image_xscale *= -1;
				x_speed = image_xscale * 4;
				y_speed = -4;
				return true;
			}
			
			// Climb
			if (input_axis_y != 0)
			{
				y_speed = KNUCKLES_CLIMB_SPEED * input_axis_y;
			}
			
			// Move
			player_move_in_air();
			//No state changed check here, seems like a bug but I dunno...
			
			// Land
			if (on_ground) return player_perform(player_is_standing);
			
			// Attach to wall
			if (not player_linecast(tilemaps, x_wall_radius * 2))
			{
				return player_perform((y_speed < 0) ? knuckles_is_lifting : knuckles_is_falling);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}
/// @function knuckles_is_lifting(phase)
function knuckles_is_lifting(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			y -= 10;
			y_speed = 0;
			break;
		}
		case PHASE.STEP:
		{
			if (animation_data.index == KNUCKLES_ANIMATION.CLIMB and animation_is_finished())
			{
				x += image_xscale * 16;
				y -= 10;
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