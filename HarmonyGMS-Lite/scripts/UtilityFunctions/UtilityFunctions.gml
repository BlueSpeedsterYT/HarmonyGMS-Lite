/// @description Checks if the given instance is visible within the game view.
/// @param {Asset.GMObject|Id.Instance} [obj] Object or instance to check (optional, default is the calling instance).
/// @param {Real} [padding] Distance in pixels to extend the size of the view when checking (optional, default is the CAMERA_PADDING macro).
/// @returns {Bool}
function instance_in_view(obj = id, padding = CAMERA_PADDING)
{
	var left = camera_get_view_x(CAMERA_ID);
	var top = camera_get_view_y(CAMERA_ID);
	var right = left + CAMERA_WIDTH;
	var bottom = top + CAMERA_HEIGHT;
	
	with (obj) return point_in_rectangle(x, y, left - padding, top - padding, right + padding, bottom + padding);
}

/// @description Creates a new particle with the given animation.
/// @param {Real} x x-coordinate of the particle.
/// @param {Real} y y-coordinate of the particle.
/// @param {Struct.animation} ani animation of the particle.
/// @param {Real} [rot] Rotation of the particle (optional, defaults to 0).
/// @param {Real} [life] Lifespan of the particle (optional, defaults to -1).
/// @param {Real} [xspd] x-speed of the particle (optional, defaults to 0).
/// @param {Real} [yspd] y-speed of the particle (optional, defaults to 0).
/// @param {Real} [xaccel] x-acceleration of the particle (optional, defaults to 0).
/// @param {Real} [yaccel] y-acceleration of the particle (optional, defaults to 0).
/// @param {Real} [depth_offset] depth offset of the particle (optional, defaults to 0).
/// @returns {Id.Instance}
function particle_create(ox, oy, ani, rot = 0, life = -1, xspd = 0, yspd = 0, xaccel = 0, yaccel = 0, depth_offset = 0)
{
    var particle = instance_create_depth(ox, oy, (ctrlZone.particles_depth + depth_offset), objParticle);
    with (particle)
    {
        animation_set(ani);
        image_angle = angle_wrap(rot);
        lifespan = life;
        x_speed = xspd;
        y_speed = yspd;
        x_acceleration = xaccel;
        y_acceleration = yaccel;
    }
    return particle;
}

/// @description Returns an option based on the given value. Ported from GM8.2.
/// @param {Real} val Value to check.
/// @param {Array} options Options to return.
/// @returns {Any}
function pick(val, options)
{
	return options[(max(val, 0) mod array_length(options))];
}

/// @description Pads the given value with zeros to occupy the specified dimensions.  Ported from GM8.2.
/// @param {Real} val Value to pad.
/// @param {Real} digits Number of spaces to occupy.
/// @returns {String}
function string_pad(val, digits)
{
    return string_repeat("-", val < 0) + string_replace_all(string_format(abs(val), digits, 0), " ", "0");
}