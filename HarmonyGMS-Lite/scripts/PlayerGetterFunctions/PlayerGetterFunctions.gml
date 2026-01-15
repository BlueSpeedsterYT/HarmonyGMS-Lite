/// @description Finds any instances intersecting a minimum bounding rectangle centered on the player, and executes their reaction.
/// It also records any solid tilemaps and instances for terrain collision detection.
function player_detect_entities()
{
	// Delist zone objects
	array_resize(tilemaps, tilemap_count);
	
	// Reset ground instance
	ground_id = noone;
	
	with (objInteractable) reaction(other);
	
	// Register semisolid tilemap
	if (semisolid_tilemap != -1 and player_beam_collision(semisolid_tilemap) == noone)
	{
		array_push(tilemaps, semisolid_tilemap);
	}
	
	/* AUTHOR NOTE:
	There is a limitation with the semisolid tilemap detection where, if the player passes through a semisolid tilemap whilst standing on one,
	they will fall as it will be delisted from their `tilemaps` array. */
}

/// @description Calculates the surface normal of the 16x16 solid chunk found at the given point.
/// @param {Real} x x-coordinate of the point.
/// @param {Real} y y-coordinate of the point.
/// @param {Real} rot Direction to extend / regress the angle sensors in multiples of 90 degrees.
/// @returns {Real}
function player_calc_tile_normal(ox, oy, rot)
{
	// Setup angle sensors
	var sine = dsin(rot);
	var cosine = dcos(rot);
	
	if (sine == 0)
	{
		var sensor_y = array_create(2, oy);
		var sensor_x = array_create(2, ox div 16 * 16);
		sensor_x[rot == 0] += 15;
	}
	else
	{
		var sensor_x = array_create(2, ox);
		var sensor_y = array_create(2, oy div 16 * 16);
		sensor_y[rot == 270] += 15;
	}
	
	// Extend / regress angle sensors
	for (var n = 0; n < 2; ++n)
	{
		repeat (y_tile_reach)
		{
			if (collision_point(sensor_x[n], sensor_y[n], tilemaps, true, false) == noone)
			{
				sensor_x[n] += sine;
				sensor_y[n] += cosine;
			}
			else if (collision_point(sensor_x[n] - sine, sensor_y[n] - cosine, tilemaps, true, false) != noone)
			{
				sensor_x[n] -= sine;
				sensor_y[n] -= cosine;
			}
			else break;
		}
	}
	
	// Calculate the direction between both angle sensors
	return point_direction(sensor_x[0], sensor_y[0], sensor_x[1], sensor_y[1]) div 1;
}


/// @description Keeps the player within the camera boundary.
/// @returns {Bool} Whether or not the player has fallen below the boundary relative to their rotation.
function player_in_camera_bounds()
{
	// Check if already inside (early out)
	if (gravity_direction mod 180 == 0)
	{
		var x1 = x - x_radius;
		var y1 = y - y_radius;
		var x2 = x + x_radius;
		var y2 = y + y_radius;
	}
	else
	{
		var x1 = x - y_radius;
		var y1 = y - x_radius;
		var x2 = x + y_radius;
		var y2 = y + x_radius;
	}
	
	with (objCamera)
	{
		var left = bound_left;
		var top = bound_top;
		var right = bound_right;
		var bottom = bound_bottom;
	}
	
	if (rectangle_in_rectangle(x1, y1, x2, y2, left, top, right, bottom) == 1)
	{
		return true;
	}
	
	// Reposition
	if (gravity_direction mod 180 == 0)
	{
		if (x1 < left)
		{
			x = left + x_radius;
			x_speed = 0;
		}
		else if (x2 > right)
		{
			x = right - x_radius;
			x_speed = 0;
		}
		else if (y1 > bottom and gravity_direction == 0)
		{
			y = bottom + y_radius;
			return false;
		}
		else if (y2 < top and gravity_direction == 180)
		{
			y = top - y_radius;
			return false;
		}
	}
	else if (y1 < top)
	{
		y = top + x_radius;
		x_speed = 0;
	}
	else if (y2 > bottom)
	{
		y = bottom - x_radius;
		x_speed = 0;
	}
	else if (x1 > right and gravity_direction == 90)
	{
		x = right + y_radius;
		return false;
	}
	else if (x2 < left and gravity_direction == 270)
	{
		x = left - y_radius;
		return false;
	}
	
	return true;
}