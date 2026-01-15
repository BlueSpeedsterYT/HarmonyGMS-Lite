function player_move_on_ground()
{
	// Ride moving platforms
	with (ground_id)
	{
		var dx = x - xprevious;
		var dy = y - yprevious;
		if (dx != 0) other.x += dx;
		if (dy != 0) other.y += dy;
	}
	
	// Initialize movement loop
	var total_steps = 1 + (abs(x_speed) div x_radius);
	var step = x_speed / total_steps;
	
	// Process movement loop
	repeat (total_steps)
	{
		// Apply movement step
		x += dcos(direction) * step;
		y -= dsin(direction) * step;
		player_in_camera_bounds(); //TODO: Add Death State
		
		// Find surrounding stage entities
		player_detect_entities();
		
		// Handle wall collision
		var hit_wall = player_beam_collision(tilemaps);
		if (hit_wall != noone)
		{
			// Eject from wall
			var wall_sign = player_wall_eject(hit_wall);
			
			// Stop if moving towards wall
			if (sign(x_speed) == wall_sign)
			{
				x_speed = 0;
			}
		}
		
		// Handle floor collision
		if (on_ground)
		{
			if (instance_exists(ground_id))
			{
				on_ground = true;
				direction = gravity_direction;
				mask_direction = gravity_direction;
				local_direction = 0;
			}
			else
			{
				//var hit_floor = player_find_floor(y_radius + (ground_snap ? y_tile_reach : 1));
				var hit_floor = player_find_floor(y_radius + min(2 + abs(x_speed) div 1, y_tile_reach));
				//var hit_floor = player_find_floor(y_radius * 2);
				if (hit_floor != undefined)
				{
					// Get floor data
					player_ground(hit_floor);
			
					// Update mask direction
					player_rotate_mask();
				}
				else on_ground = false;
			}
		}
	}
}

/// @description Updates the player's position in the air and checks for collisions.
function player_move_in_air()
{
	// Initialize horizontal movement loop
	var total_steps = 1 + (abs(x_speed) div x_radius);
	var step = x_speed / total_steps;
	
	// Process horizontal movement loop
	repeat (total_steps)
	{
		// Apply movement step
		x += dcos(mask_direction) * step;
		y -= dsin(mask_direction) * step;
		player_in_camera_bounds();
		
		// Find surrounding stage objects
		player_detect_entities();
		
		// Handle wall collision
		var hit_wall = player_beam_collision(tilemaps);
		if (hit_wall != noone)
		{
			// Eject from wall
			var wall_sign = player_wall_eject(hit_wall);
			
			// Stop if moving towards wall
			if (sign(x_speed) == wall_sign) x_speed = 0;
		}
	}
	
	// Initialize vertical movement loop
	total_steps = 1 + (abs(y_speed) div y_radius);
	step = y_speed / total_steps;
	
	// Process vertical movement loop
	repeat (total_steps)
	{
		// Apply movement step
		x += dsin(mask_direction) * step;
		y += dcos(mask_direction) * step;
		player_in_camera_bounds();
		
		// Find surrounding stage objects
		player_detect_entities();
		
		// Handle floor/ceiling collisions
		if (y_speed >= 0)
		{
			if (instance_exists(ground_id))
			{
				landed = true;
				on_ground = true;
				direction = gravity_direction;
				mask_direction = gravity_direction;
				local_direction = 0;
			}
			else
			{
				// Floor collision
				var hit_floor = player_find_floor(y_radius);
				if (hit_floor != undefined)
				{
					// Get floor data
					landed = true;
					player_ground(hit_floor);
				
					// Update mask direction
					player_rotate_mask();
				}
			}
		}
		else
		{
			// Ceiling collision
			var hit_floor = player_find_ceiling(y_radius);
			if (hit_floor != undefined)
			{
				// Flip mask and land on the ceiling
				mask_direction = (mask_direction + 180) mod 360;
				landed = true;
				player_ground(hit_floor);
				
				// Abort if rising too slow or ceiling is too shallow
				if (y_speed > CEILING_LAND_THRESHOLD or (local_direction > 135 and local_direction < 225))
				{
					// Slide against ceiling
					var sine = dsin(local_direction);
					var cosine = dcos(local_direction);
					var g_speed = (cosine * x_speed) - (sine * y_speed);
	                x_speed = cosine * g_speed;
					y_speed = -sine * g_speed;
					
					// Revert mask rotation and exit loop
					mask_direction = gravity_direction;
					landed = false;
					break;
				}
			}
		}
		
		// Landing
		if (landed)
		{
			// Calculate landing speed
			if (abs(x_speed) <= abs(y_speed) and local_direction >= 22.5 and local_direction <= 337.5)
			{
				// Scale speed to incline
			    x_speed = -y_speed * sign(dsin(local_direction));
			    if (local_direction < 45 or local_direction > 315) x_speed *= 0.5;
			}
			
			// Stop falling
			y_speed = 0;
			
			// Set flags and exit loop
			landed = false;
			on_ground = true;
			player_refresh_aerial_skills();
			break;
		}
		
		// Handle wall collision (again)
		hit_wall = player_beam_collision(tilemaps);
		if (hit_wall != noone) player_wall_eject(hit_wall);
	}
}