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
				x_speed = 4 * image_xscale;
				y_speed = -4;
				return true;
			}
			
			// Climb
			y_speed = knuckles_climb_speed * input_axis_y;
			
			// Move
			player_move_in_air();
			//No state changed check here, seems like a bug but I dunno...
			
			// Land
			if (on_ground) return player_perform(player_is_standing);
			
			// Attach to wall
			var hit_wall = player_beam_collision(tilemaps, x_wall_radius * 2);
			if (hit_wall == noone)
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
			break;
		}
		case PHASE.STEP:
		{
			
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}