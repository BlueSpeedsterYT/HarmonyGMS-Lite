/// @description Moves the player's virtual mask out of collision with the given wall.
/// @param {Id.Instance|Id.TileMapElement} inst Instance or tilemap to eject from.
/// @returns {Real} Sign of the wall from the player.
function player_wall_eject(inst)
{
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	var inside = collision_point(x div 1, y div 1, inst, true, false) != noone;
	
	for (var ox = 1; ox <= x_wall_radius; ++ox)
	{
		if (not inside)
		{
			// Left of the wall
			if (player_ray_collision(inst, ox, 0))
			{
				x -= cosine * (x_wall_radius - ox + 1);
				y += sine * (x_wall_radius - ox + 1);
				return 1;
			}
			else if (player_ray_collision(inst, -ox, 0)) // Right of the wall
			{
				x += cosine * (x_wall_radius - ox + 1);
				y -= sine * (x_wall_radius - ox + 1);
				return -1;
			}
		}
		else if (not player_ray_collision(inst, ox, 0)) // Right of the wall
		{
			x += cosine * (x_wall_radius + ox);
			y -= sine * (x_wall_radius + ox);
			return -1;
		}
		else if (not player_ray_collision(inst, -ox, 0)) // Left of the wall
		{
			x -= cosine * (x_wall_radius + ox);
			y += sine * (x_wall_radius + ox);
			return 1;
		}
	}
	
	return 0;
}

/// @description Aligns the player to the ground using the given height and updates their angle values.
/// If undefined is passed instead, the player is detached from the ground.
/// @param {Real|Undefined} height Amount in pixels to reposition the player, if applicable.
function player_ground(height)
{
	if (height != undefined)
	{
		var offset = y_radius - height + 1;
		x -= dsin(mask_direction) * offset;
		y -= dcos(mask_direction) * offset;
		
		player_detect_angle();
	}
	else
	{
		on_ground = false;
		objCamera.on_ground = false;
		mask_direction = gravity_direction;
	}
}

/// @function player_detect_angle()
/// @description Sets the player's angle values.
function player_detect_angle()
{
	// Check for ground collision using all vertical sensors
	var edge = 0;
	if (player_ray_collision(tilemaps, -x_radius, y_radius + 1)) edge |= 1;
	if (player_ray_collision(tilemaps, x_radius, y_radius + 1)) edge |= 2;
	if (player_ray_collision(tilemaps, 0, y_radius + 1)) edge |= 4;
	
	// Abort on no collision
	if (edge == 0) exit;
	
	// Define offset point from which the ground normal should be calculated
	var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
	var ox = x div 1 + sine * y_radius;
	var oy = y div 1 + cosine * y_radius;

	// Calculate the ground normal and set new angle values
	if (edge & (edge - 1) == 0) // Check if only one sensor is grounded (power of 2 calculation)
	{
		// Reposition offset point, if applicable
		if (edge == 1)
		{
			ox -= cosine * x_radius;
			oy += sine * x_radius;
		}
		else if (edge == 2)
		{
			ox += cosine * x_radius;
			oy -= sine * x_radius;
		}
		direction = player_calc_tile_normal(ox, oy, mask_direction);
	}
	else direction = mask_direction;
	local_direction = angle_wrap(direction - gravity_direction);
}

/// @description Resets the player's physics variables back to their default values, applying any modifiers afterward.
function player_refresh_physics()
{
	// Speed values
	speed_cap = 6;
	acceleration = 0.046875;
	deceleration = 0.5;
	air_acceleration = 0.09375;
	roll_deceleration = 0.125;
	roll_friction = 0.0234375;
	
	// Aerial values
	gravity_cap = 16;
	gravity_force = 0.21875;
	recoil_gravity = 0.1875;
	jump_height = 6.5;
	jump_release = 4;
	
	// Trick values
	trick_bound_height = 6;
	
	// Character values
	sonic_bound_force = 0.21875;
	sonic_bound_height = 6;
	knuckles_glide_acceleration = 0.015625;
	knuckles_glide_slide_friction = 0.125;
	knuckles_climb_speed = 1;
	
	// Superspeed modification
	if (superspeed_time > 0)
	{
		speed_cap *= 2;
		acceleration *= 2;
		air_acceleration *= 2;
		roll_friction *= 2;
	}
}