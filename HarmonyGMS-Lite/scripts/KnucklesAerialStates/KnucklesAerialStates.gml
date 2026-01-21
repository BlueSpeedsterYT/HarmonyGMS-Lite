/// @function knuckles_is_gliding(phase)
function knuckles_is_gliding(phase)
{
	switch(phase)
	{
		case PHASE.ENTER:
		{
			// Rise
			y_speed = -dsin(local_direction) * x_speed;
			x_speed *= dcos(local_direction);
			
			// Detach from ground
			player_ground(undefined);
			
			// Adjust Y Speed
			if (y_speed <= -8) 
			{
		        y_speed *= 0.25;
		    } 
			else if (y_speed < 0) 
			{
		        y_speed = 0;
		    }
			
			// Set up Gliding values
			glide_speed = 4;
		    glide_direction = image_xscale;
		    glide_angle = 90 - (90 * image_xscale);
		    glide_force = 0.5;
			
			// Animate
			animation_init(KNUCKLES_ANIMATION.GLIDE);
			break;
		}
		case PHASE.STEP:
		{
			// Glide fall
			if (not input_button.jump.check)
			{
				return player_perform(knuckles_is_falling);
			}
			
			// Change Gliding direction
			if (input_axis_x != 0) 
			{
		        glide_direction = input_axis_x;
		    }
			
			// Give speed if dead ahead
			if (abs(glide_angle) mod 180 == 0) 
			{
		        if (glide_speed < 16)
				{
					glide_speed = min(glide_speed + KNUCKLES_GLIDE_ACCELERATION, 16);
				}
		    }

		    // Clamp the gliding angle
			glide_angle = clamp(glide_angle - (2.8125 * glide_direction), 0, 180);

		    // Accelerate
			x_speed = glide_speed * dcos(glide_angle);
			
			// Attach to a wall and climb
			// NOTE: Might tackle this later as it does impact the gliding state
			//if (player_ray_collision(tilemaps, x_wall_radius * glide_direction, 0) != noone)
			//{
				//return player_perform(knuckles_is_climbing);
			//}
			
			// Move
			player_move_in_air();
			if (state_changed) exit;
			
			// Land
			if (on_ground) 
			{
				if (x_speed != 0) image_xscale = sign(x_speed);
				if (local_direction >= 45 and local_direction <= 315)
				{
					control_lock_time = SLIDE_DURATION;
					return player_perform(player_is_running);
				}
				else
				{
					return player_perform(knuckles_is_sliding);
				}
			}
			
			// Gliding force
			if (glide_force < 0.5) 
			{
		        glide_force = min(glide_force + 0.125, 0.5);
		    }

		    // Set up gliding force accordingly
			var oy = glide_force - y_speed;
		    if (abs(oy) > 0) 
			{
		        y_speed += min(abs(oy), 0.125) * sign(oy);
			}
			
			// Animate
			// NOTE: If you're ever going to tackle an Advance 2 Knuckles please do better than what
			// I have done here, it would be wise if you understood how to make this stuff work
			// without needing to do all of this.
			var glide_angle_sa2 = (glide_angle / 1.40625);
			image_xscale = (glide_angle_sa2 == 0x80) ? -1 : 1;
			if (not (glide_angle_sa2 & 0x7F))
			{
				animation_init(KNUCKLES_ANIMATION.GLIDE);
			}
			else
			{
				var glide_turn_sa2_calc = (glide_angle_sa2 & 0x7F) >> 5;
				animation_init(KNUCKLES_ANIMATION.GLIDE_TURN, glide_turn_sa2_calc);
			}
			break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}

/// @function knuckles_is_falling(phase)
function knuckles_is_falling(phase)
{
	switch(phase)
	{
		case PHASE.ENTER:
		{
			// Rise
			y_speed = -dsin(local_direction) * x_speed;
			x_speed *= dcos(local_direction);
			
			// Detach from ground
			player_ground(undefined);
			
			// Slow horizontal speed
			x_speed *= 0.25;
			
			// Animate
			animation_init(KNUCKLES_ANIMATION.GLIDE_FALL, 0);
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
			if (on_ground) 
			{
				if (local_direction >= 45 and local_direction <= 315)
				{
					control_lock_time = SLIDE_DURATION;
					return player_perform(player_is_running);
				}
				else
				{
					return player_perform(knuckles_is_landing);
				}
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

/// @function knuckles_is_preparing_drill_clawing(phase)
function knuckles_is_preparing_drill_clawing(phase)
{
	switch (phase)
	{
		case PHASE.ENTER:
		{
			// Stop
			x_speed = 0;
			y_speed = 0;
			
			// Play Sound
			sound_play(sfxKnucklesDrillClaw);
			
			// Animate
			animation_init(PLAYER_ANIMATION.TRICK_DOWN);
			break;
		}
		case PHASE.STEP:
		{
			// Trick
			if (animation_is_finished())
			{
				y_speed = 1;
				return player_perform(knuckles_is_drill_clawing);
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

/// @function knuckles_is_drill_clawing(phase)
function knuckles_is_drill_clawing(phase)
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
			if (animation_data.variant == 2)
            {
                // Move
                player_move_on_ground();
                if (state_changed) exit;
                
                // Fall
                if (not on_ground) return player_perform(player_is_falling);
                
                // Stand
                if (animation_is_finished()) return player_perform(player_is_standing);
            }
            else
            {
                // Move
    			player_move_in_air();
    			if (state_changed) exit;
    			
    			// Land
    			if (on_ground) return player_perform(knuckles_is_drill_clawing);
    			
    			// Apply air resistance
    			if (y_speed < 0 and y_speed > -4 and abs(x_speed) > AIR_DRAG_THRESHOLD)
    			{
    				x_speed *= AIR_DRAG;
    			}
    			
    			// Fall
    			if (y_speed < gravity_cap)
    			{
    				y_speed = min(y_speed + (42 / 256), gravity_cap);
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

/// @function knuckles_is_somersaulting(phase)
function knuckles_is_somersaulting(phase)
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
			if (on_ground)
            {
                // Move
                player_move_on_ground();
                if (state_changed) exit;
            }
            else
            {
                // Move
    			player_move_in_air();
    			if (state_changed) exit;
                
                // Fall
                if (not on_ground)
                {
                    if (y_speed < gravity_cap)
        			{
        				y_speed = min(y_speed + gravity_force, gravity_cap);
        			}
                }
            }
            
            // Roll
            if (animation_is_starting(5)) sound_play(sfxRoll);
            if (animation_is_finished())
            {
                animation_init(PLAYER_ANIMATION.ROLL);
                return player_perform(on_ground ? player_is_rolling : player_is_falling, false);
            }
            break;
		}
		case PHASE.EXIT:
		{
			break;
		}
	}
}