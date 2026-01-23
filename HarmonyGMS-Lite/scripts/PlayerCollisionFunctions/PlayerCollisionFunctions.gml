/// @function player_collision(obj)
/// @description Checks if the given entity's mask intersects the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap to check.
/// @returns {Bool}
function player_collision(obj)
{	
	return collision_box(x_radius, y_radius, mask_direction mod 180 == 0, obj) != noone;
}

/// @function player_part_collision(obj, ylen)
/// @description Checks if the given entity's mask intersects a vertical portion of the player's virtual mask.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap to check.
/// @param {Real} ylen Distance in pixels to extend the player's mask vertically.
/// @returns {Bool}
function player_part_collision(obj, ylen)
{
	return collision_box_vertical(x_radius, ylen, mask_direction, obj) != noone;
}

/// @function player_ray_collision(obj, xoff, ylen)
/// @description Checks if the given entity's mask intersects a line from the player's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap to check.
/// @param {Real} xoff Distance in pixels to offset the line horizontally.
/// @param {Real} ylen Distance in pixels to extend the line downward.
/// @returns {Bool}
function player_ray_collision(obj, xoff, ylen)
{
	return collision_ray(xoff, ylen, mask_direction, obj) != noone;
}

/// @function player_beam_collision(obj, [xrad], [yoff])
/// @description Checks if the given entity's mask intersects a line from the player's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap to check.
/// @param {Real} [xrad] Distance in pixels to extend the line horizontally on both ends (optional, default is the player's wall radius).
/// @param {Real} [yoff] Distance in pixels to offset the line vertically (optional, default is 0).
/// @returns {Asset.GMObject|Id.Instance|Id.TileMapElement}
function player_beam_collision(obj, xrad = x_wall_radius, yoff = 0)
{
	return collision_beam(xrad, yoff, mask_direction, obj);
}

/// @function player_arm_collision(obj, [xrad], [yoff])
/// @description Checks if the given entity's mask intersects an "arm" from the player's position.
/// @param {Asset.GMObject|Id.Instance|Id.TileMapElement} obj Object, instance or tilemap to check.
/// @param {Real} [xrad] Distance in pixels to extend the line horizontally in one direction (optional, default is the player's wall radius).
/// @param {Real} [yoff] Distance in pixels to offset the line vertically (optional, default is 0).
/// @returns {Asset.GMObject|Id.Instance|Id.TileMapElement}
function player_arm_collision(obj, xrad = x_wall_radius, yoff = 0)
{
	return collision_arm(xrad, yoff, mask_direction, obj);
}