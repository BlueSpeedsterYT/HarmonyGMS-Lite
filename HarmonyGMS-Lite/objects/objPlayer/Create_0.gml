/// @description Initialize
image_speed = 0;

character_index = CHARACTER.NONE;
player_index = -1;

// State machine
state = player_is_ready;
state_previous = state;
state_changed = false;

spin_dash_charge = 0;
spin_dash_dust = new stamp();

aerial_flags = 0;

jump_cap = true;

trick_index = TRICK_TYPE.FRONT;
trick_speed = array_create(TRICK_TYPE.BACK + 1);
for (var i = 0; i < array_length(trick_speed); i++)
{
    trick_speed[i] = array_create(2);
}

// Timers
rotation_lock_time = 0;
control_lock_time = 0;
state_time = 0;

recovery_time = 0;
invincibility_time = 0;
superspeed_time = 0;

// Boost Mode
boost_mode = false;
boost_index = 0;
boost_speed = 0;
boost_threshold = [8.0, 7.96875, 6.5625, 5.625, 4.21875];

// Status
/// @method player_refresh_status()
/// @description Resets the player's status.
player_refresh_status = function()
{
    shield.index = SHIELD_TYPE.NONE;
    aerial_flags &= ~AERIAL_FLAG.SHIELD_ACTION;
    recovery_time = 0;
    invincibility_time = 0;
    superspeed_time = 0;
    confusion_time = 0;
};

shield = new stamp();
player_refresh_status();

// Physics
x_speed = 0;
y_speed = 0;
underwater = false;
player_refresh_physics();

// Collision detection
x_radius = 8;
x_wall_radius = 10;

y_radius = 15;
y_tile_reach = 16;

hitboxes[0] = new hitbox(c_maroon);
hitboxes[1] = new hitbox(c_green);

landed = false;
on_ground = true;
//ground_snap = true;

direction = 0;
gravity_direction = 0;
local_direction = 0;
mask_direction = 0;

/* AUTHOR NOTE: "down" is treated as 0 degrees instead of 270. */

collision_layer = 0;

// Copy the stage's tilemaps
tilemaps = variable_clone(ctrlZone.tilemaps, 0);
tilemap_count = array_length(tilemaps);

// Validate semisolid tilemap; if it exists, the tilemap count is even
semisolid_tilemap = -1;
if (tilemap_count & 1 == 0)
{
	semisolid_tilemap = array_last(tilemaps);
	--tilemap_count;
}

// Discard the "CollisionPlane1" layer tilemap, if it exists
if (tilemap_count == 3)
{
	array_delete(tilemaps, 2, 1);
	--tilemap_count;
}

ground_id = noone;

// Input
input_allow = false;
input_axis_x = 0;
input_axis_pressed_x = 0;
input_axis_y = 0;
input_axis_pressed_y = 0;
input_double_tap_timer_x = 0;
input_double_tap_timer_y = 0;
input_double_tap_direction_x = 0;
input_double_tap_direction_y = 0;

/// @method button(verb)
/// @description Creates a new button.
/// @param {Enum.INPUT_VERB} verb Verb to check.
button = function(_verb) constructor
{
	verb = _verb;
	check = false;
	pressed = false;
	released = false;
};

// NOTE: This button index follows the same order as Advance 2.
input_button =
{
	jump : new button(INPUT_VERB.JUMP),
	attack : new button(INPUT_VERB.ATTACK),
	trick : new button(INPUT_VERB.TRICK),
    start : new button(INPUT_VERB.START),
    select : new button(INPUT_VERB.SELECT)
};

/// @method player_refresh_inputs()
/// @description Resets all player input.
player_refresh_inputs = function()
{
	input_axis_x = 0;
	input_axis_pressed_x = 0;
	input_axis_y = 0;
	input_axis_pressed_y = 0;
	input_double_tap_direction_x = 0;
	input_double_tap_direction_y = 0;
	
	struct_foreach(input_button, function(name, value)
	{
		var verb = value.verb;
		value.check = false;
		value.pressed = false;
		value.released = false;
	});
};

// Animation
animation_data = new animation_core();

/// @method player_animate_run(ani)
/// @description Sets the given animation within the player's animation core based on running conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
/// @param {Real} [ang] Angle to set (optional, defaults to direction).
player_animate_run = function(ani, ang = direction)
{
    var variant = (on_ground ? 5 : animation_data.variant);
    if (on_ground)
    {
    	var abs_speed = abs(x_speed);
    	if (abs_speed <= 1.25) variant = 0;
	    else if (abs_speed <= 2.5) variant = 1;
	    else if (abs_speed <= 4.0) variant = 2;
	    else if (abs_speed <= 9.0) variant = 3;
	    else if (abs_speed <= 10.0) variant = 4;
    }
	var angle = on_ground ? ang : rotate_towards(mask_direction, image_angle);
    player_set_animation(ani, angle);
    animation_data.variant = variant;
    if (on_ground) animation_data.speed = clamp((abs(x_speed) / 3) + (abs(x_speed) / 4), 0.5, 8);
};

/// @method player_animate_fall(ani)
/// @description Sets the given animation within the player's animation core based on falling conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_fall = function(ani)
{
	if (animation_data.variant == 0 and animation_is_finished()) animation_data.variant = 1;
    player_set_animation(ani, rotate_towards(mask_direction, image_angle));
};

/// @method player_animate_jump(ani)
/// @description Sets the given animation within the player's animation core based on jumping conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_jump = function(ani)
{
	switch (animation_data.variant)
    {
        case 0:
        {
            if (animation_is_finished()) animation_data.variant = 1;
            break;
        }
        case 1:
        {
            if (y_speed > 0 and not is_undefined(player_find_floor(y_radius + 32))) animation_data.variant = 2;
            break;
        }
    }
    player_set_animation(ani);
};


/// @method player_animate_spring(ani)
/// @description Plays the given animation based on spring conditions.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
player_animate_spring = function(ani)
{
    switch (animation_data.variant)
    {
        case 0:
        {
            if (y_speed > 0) animation_data.variant = 1;
            break;
        }
        case 1:
        {
            if (animation_is_finished()) animation_data.variant = 2;
            break;
        }
    }
    
    player_set_animation(ani);
};

/// @method animation_record()
/// @description Creates a new animation record.
animation_record = function() constructor
{
    x = 0;
    y = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    ani = undefined;
    ani_speed = 1;
};

animation_history_index = 0;
animation_history = array_create(ANIMATION_RECORD_COUNT);
for (var i = 0; i < ANIMATION_RECORD_COUNT; i++)
{
    animation_history[i] = new animation_record();
}

/// @method player_update_animation_history()
/// @description Updates the animation history.
player_update_animation_history = function()
{
    with (animation_history[animation_history_index])
    {
        x = other.x div 1;
        y = other.y div 1;
        image_xscale = other.image_xscale;
        image_yscale = other.image_yscale;
        image_angle = other.image_angle;
        ani = other.animation_data.ani;
        ani_speed = other.animation_data.speed;
    }
    
    animation_history_index = ++animation_history_index mod ANIMATION_RECORD_COUNT;
};

// Afterimage
/// @method afterimage()
/// @description Creates a new afterimage.
afterimage = function() constructor 
{
    time = 0;
    sprite_index = -1;
    image_index = 0;
    image_xscale = 1;
    image_yscale = 1;
    image_angle = 0;
    image_blend = c_white;
    image_alpha = 1;
    animation_data = new animation_core();
}

afterimage_visible = false;
afterimage_list = array_create(AFTERIMAGE_COUNT);
for (var i = 0; i < AFTERIMAGE_COUNT; i++)
{
    afterimage_list[i] = new afterimage();
}

// Speed Break
speed_break =
{
    x : 0,
    y : 0,
    positions : array_create(SPEED_BREAK_COUNT),
    accelerations : array_create(SPEED_BREAK_COUNT),
    unkE2 : 128,
    unkE4 : 0,
    time : 0,
    sprite_index : -1,
    image_index : 0,
    image_angle : 0,
    animation_data : new animation_core(),
    visible : false
};

with (speed_break)
{
    for (var i = 0; i < SPEED_BREAK_COUNT; i++)
    {
        positions[i] = array_create(2);
        accelerations[i] = array_create(2);
    }
}

// Misc.
/// @method player_perform(action, [start])
/// @description Sets the given function as the player's current state.
/// @param {Function} action State function to set.
/// @param {Boolean} [start] Start state function.
player_perform = function(action, start = true)
{
	var reset = (argument_count > 1);
	if (state != action or reset)
	{
		state_previous = state;
		state = action;
		state_changed = true;
		if (script_exists(state_previous)) state_previous(PHASE.EXIT);
		if (start)
		{
			if (script_exists(state)) state(PHASE.ENTER);
		}
	}
};

/// @method player_try_jump()
/// @description Sets the player's current state to jumping, if applicable.
/// @returns {Bool}
player_try_jump = function()
{
	if (input_button.jump.pressed)
	{
		player_perform(player_is_jumping);
		animation_play(PLAYER_ANIMATION.JUMP);
		sound_play(sfxJump);
		return true;
	}
	return false;
};

/// @method player_try_appeal()
/// @description Sets the player's current state to appeal, if applicable.
/// @returns {Bool}
player_try_appeal = function()
{
	if (input_axis_y == -1 and x_speed == 0)
	{
		player_perform(player_is_appealing);
		animation_play(PLAYER_ANIMATION.APPEAL);
		return true;
	}
	return false;
};

/// @method player_try_crouch_or_roll()
/// @description Sets the player's current state to either crouching or rolling, if applicable.
/// @returns {Bool}
player_try_crouch_or_roll = function()
{
	if (input_axis_y == 1)
	{
		if ((abs(x_speed) + 0.49609375) > ROLL_THRESHOLD or mask_direction != gravity_direction)
		{
			sound_play(sfxRoll);
			player_perform(player_is_rolling);
			animation_play(PLAYER_ANIMATION.ROLL);
			return true;
		}
		else if (x_speed == 0)
		{
			player_perform(player_is_crouching);
			animation_play(PLAYER_ANIMATION.CROUCH);
			return true;
		}
	}
	return false;
};

/// @method player_try_trick([time])
/// @desctiption Sets the player's current state to tricking, if applicable.
/// @param [time] Time to check (optional, defaults to state_time).
/// @returns {Bool}
player_try_trick = function(time = state_time)
{
	if (time == 0 and input_button.trick.pressed)
	{
		trick_index = TRICK_TYPE.BACK;
		if (input_axis_y == -1)
		{
			trick_index = TRICK_TYPE.UP;
		}
		else if (input_axis_y == 1)
		{
			trick_index = TRICK_TYPE.DOWN;
			if (object_index == objSonic) boost_mode = false;
		}
		else if (input_axis_x == image_xscale)
		{
			trick_index = TRICK_TYPE.FRONT;
		}

        player_gain_score(100);
		player_perform(player_is_trick_preparing);
		if (not (object_index == objSonic and trick_index == TRICK_TYPE.DOWN))
		{
			var trick_claw = (object_index == objKnuckles and trick_index == TRICK_TYPE.DOWN);
			sound_play(trick_claw ? sfxKnucklesDrillClaw : sfxDefaultTrick);
		}
		return true;
	}
	return false;
};

/// @method player_try_skill()
/// @description Checks if the player performs a character skill.
/// @returns {Bool}
player_try_skill = function()
{
	switch (object_index)
	{
		case objSonic:
		{
			if (not on_ground)
			{
				if (input_button.attack.pressed)
				{
					// Bound
					if (state != sonic_is_preparing_bound)
					{
						player_perform(sonic_is_preparing_bound);
						return true;
					}
				}
				else if (input_button.jump.pressed)
				{
					// Insta-Shield (or Homing Attack at close distances)
					// TODO: Implement some sort of range check to allow for the homing attack to take
					// over from the insta-shield
					if (not (aerial_flags & AERIAL_FLAG.SHIELD_ACTION))
					{
						aerial_flags |= AERIAL_FLAG.SHIELD_ACTION;
						with (insta_shield)
						{
							x = other.x div 1;
							y = other.y div 1;
							depth = other.depth;
							image_xscale = other.image_xscale;
							image_angle = other.image_angle;
				
							animation_set(global.ani_sonic_insta_shield_v1);
						}
						animation_play(SONIC_ANIMATION.INSTA_SHIELD);
						sound_play(sfxSonicInstaShield);
						player_perform(player_is_falling, false);
						return true;
					}
				}
				else if (input_axis_pressed_x != 0 and sign(input_double_tap_direction_x) == image_xscale)
				{
					// Forward Thrust
					if (not (aerial_flags & AERIAL_FLAG.FORWARD_THRUST))
					{
						aerial_flags |= AERIAL_FLAG.FORWARD_THRUST;
						x_speed += (2.25 * input_double_tap_direction_x);
						y_speed = 0;
						animation_play(SONIC_ANIMATION.FORWARD_THRUST);
						sound_play(sfxSonicThrust);
						player_perform(player_is_falling, false);
						return true;
					}
				}
			}
			else
			{
				if (input_button.attack.pressed)
				{
					// Skid Attack
					// Sonic's skid attack is simple and effective, however
					// it gets supercharged while in boost mode, the skys the limit with this power.
					// so use it wisely.
					if (not (mask_direction != gravity_direction))
					{
						player_perform(sonic_is_skidding);
						return true;
					}
				}
			}
			break;
		}
		case objTails:
		{
			if (not on_ground)
			{
			    // Tails has no air attacks so he only got to have the jump skill.
				// Good for him.
				// Sadly his flight is screwed over by water which is different than Sonic 3 so uhhhhhh.
				if (input_button.jump.pressed)
			    {
					// Fly
					// Like Sonic 3, he can go to higher bounds never expected.
					// Unlike Sonic 3, he can't swim with it, cuz the state for it is not in
					// the Advance games.
					if (state != tails_is_flying and fly_time < TAILS_FLY_DURATION and (not underwater))
					{
						player_perform(tails_is_flying);
						return true;
					}
			    }
			}
			else
			{
				// However, unlike the air, Tails does have a ground attack...
				// it is a ground attack.
				if (input_button.attack.pressed)
				{
					// Tail Swipe
					// it is a swiping attack.
					if (not (mask_direction != gravity_direction))
					{
						player_perform(tails_is_tail_swipe);
						return true;
					}
				}
			}
			break;
		}
		case objKnuckles:
		{
			if (not on_ground)
			{
				if (input_button.attack.pressed)
				{
					// Drill Claw
					if (state != knuckles_is_preparing_drill_clawing)
					{
						player_perform(knuckles_is_preparing_drill_clawing);
						return true;
					}
				}
				else if (input_button.jump.pressed)
				{
					// Glide
					// Unlike Sonic 3 for some reason, Knuckles can not glide underwater. Like at all.
					// Maybe it's done to save on power and math on how his gliding works?
					// SA1 allows him to float above water so I dunno...
					if (state != knuckles_is_gliding and (not underwater))
					{
						player_perform(knuckles_is_gliding);
						return true;
					}
				}
			}
			else
			{
				if (input_button.attack.pressed)
				{
					// Punch/Spiral Attack
					// If the player is not in boost mode, then Knuckles would do a simple punch.
					// however, that punch turns into a spiral strike when in boost mode.
					// Be noteful on how you handle that.
					if (not (mask_direction != gravity_direction))
					{
						player_perform((not boost_mode) ? knuckles_is_punching_left : knuckles_is_sprial_attack);
						return true;
					}
				}
			}
			break;
		}
	}
	
	return false;
}


/// @method player_refresh_aerials()
/// @description Resets aerial character skills when grounded.
player_refresh_aerials = function() 
{
	switch (object_index)
	{
		default: break;
		case objTails:
		{
			if (on_ground) fly_time = 0;
			break;
		}
	}
};

/// @method player_rotate_mask()
/// @description Rotates the player's collision mask along steep enough ground.
player_rotate_mask = function()
{
	if (rotation_lock_time > 0 and not landed)
	{
		--rotation_lock_time;
		exit;
	}
	
	var new_rotation = round(direction / 90) mod 4 * 90;
	if (mask_direction != new_rotation)
	{
		mask_direction = new_rotation;
		rotation_lock_time = (not landed) * max(16 - abs(x_speed * 2) div 1, 0);
	}
}

/// @method player_resist_slope(force, threshold)
/// @description Applies slope friction to the player's horizontal speed, if appropriate.
/// @param {Real} force Friction value to use.
/// @param {Real} threshold Threshold value to use.
player_resist_slope = function(force, threshold)
{
	var sine_value = dsin(local_direction);
	// Abort if...
	if (not on_ground) exit; // Not on the ground
	if (sign(sine_value) == sign(x_speed)) exit; // The signed sine value is equal to the signed horizontal speed value
	if (local_direction < 22.5 or local_direction > 337.5) exit; // Moving on a shallow surface
	if (abs(sine_value * force) <= threshold) exit; // Is under the provided threshold
	
	// Apply
	x_speed -= sine_value * force;
};

/// @method player_resist_air([resistance_amount])
/// @description Updates the player's air resistance
/// @param {Real} [resistance_amount] Amount of resistance given to the player (optional, defaults to 32).
player_resist_air = function(resistance_amount = 32)
{
	if (y_speed < 0 and y_speed > -AIR_THRESHOLD)
	{
		x_speed -= x_speed / resistance_amount;
	}
}

/// @method player_set_animation(ani, [ang])
/// @description Sets the given animation within the player's animation core.
/// @param {Undefined|Struct.animation|Array} ani Animation to set. Accepts an array as animation variants.
/// @param {Real} [ang] Angle to set (optional, defaults to gravity_direction).
player_set_animation = function(ani, ang = gravity_direction)
{
	animation_set(ani);
	image_angle = ang;
};

/// @method player_set_radii(xrad, yrad)
/// @description Sets the given radii as the player's virtual mask.
/// @param {Real} xrad Horizontal radius to use.
/// @param {Real} yrad Vertical radius to use.
player_set_radii = function(xrad, yrad)
{
    // Abort if radii already match
    if (x_radius == xrad and y_radius == yrad) exit;
    
    var old_x_radius = x_radius;
    var old_y_radius = y_radius;
    var sine = dsin(mask_direction);
	var cosine = dcos(mask_direction);
    x_radius = xrad;
    x_wall_radius = x_radius + 2;
    y_radius = yrad;
	
    if (on_ground)
    {
        x += sine * (old_y_radius - y_radius);
        y += cosine * (old_y_radius - y_radius);
    }
};

/// @method player_gain_score(num)
/// @description Increases the player's score count by the given amount.
/// @param {Real} num Amount of points to give.
player_gain_score = function(num)
{
	var previous_count = global.score_count div 50000;
	global.score_count = min(global.score_count + num, SCORE_CAP);
	
	// Gain lives
	if (LIVES_ENABLED)
	{
		var count = global.score_count div 50000;
		if (count != previous_count) player_gain_lives(count - previous_count);
	}
};

/// @method player_gain_rings(num)
/// @description Increases the player's ring count by the given amount.
/// @param {Real} num Amount of rings to give.
player_gain_rings = function(num)
{
	global.ring_count = min(global.ring_count + num, RING_CAP);
	
	// Gain lives
	if (LIVES_ENABLED)
	{
	    if (global.ring_count > global.ring_life_threshold)
	    {
	        var change = global.ring_count div 100;
	        player_gain_lives(change - global.ring_life_threshold div 100);
	        global.ring_life_threshold = change * 100 + RING_LIFE_BASE_THRESHOLD;
	    }
	}
};

/// @method player_lose_rings()
/// @description Creates up to 32 lost rings in circles of 16 at the player's position.
player_lose_rings = function()
{
    var spd = 4;
    var dir = 101.25;
    
    for (var n = min(global.ring_count, 32); n > 0; --n)
    {
        with (instance_create_depth(x div 1, y div 1, ctrlZone.stage_depth, objRing))
        {
            gravity_direction = other.gravity_direction;
			image_angle = gravity_direction;
			
			lost = true;
            x_speed = lengthdir_x(spd, dir);
            y_speed = lengthdir_y(spd, dir);
            if (n & 1 != 0)
            {
                x_speed *= -1;
                dir += 22.5;
            }
        }
		
		if (n == 16)
		{
			spd = 2;
            dir = 101.25;
		}
    }
    
    global.ring_count = 0;
    sound_play(sfxRingLoss);
};

/// @method player_gain_lives(num)
/// @description Increases the player's life count by the given amount.
/// @param {Real} num Amount of lives to give.
player_gain_lives = function(num)
{
	if (LIVES_ENABLED)
    {
        global.life_count = min(global.life_count + num, LIVES_CAP);
        music_overlay(mus1Up);
    }
};

/// @method player_damage(inst)
/// @description Evaluates the player's condition after taking a hit.
/// Setting inst to the player's id will force a death, while setting it to noone will just hurt the player.
/// @param {Id.Instance} inst Instance to check.
player_damage = function(inst)
{
    // Abort if the player is already dead or hurt
    if (state == player_is_dead or ((state == player_is_hurt or recovery_time > 0 or invincibility_time > 0) and inst != id)) exit;
    
    if (inst == id or (player_index == 0 and shield.index == SHIELD_TYPE.NONE and global.ring_count == 0))
    {
        y_speed = -7;
        sound_play(sfxHurt);
        return player_perform(player_is_dead);
    }
    else
    {
    	var hurt_speed = -2;
        var ring_loss = false;
        animation_play(PLAYER_ANIMATION.HURT);
        if (inst == noone or abs(x_speed) <= 2.5)
        {
            if (abs(x_speed) > 0.625) x_speed = sign(x_speed) * hurt_speed;
            else x_speed = image_xscale * hurt_speed;
            animation_data.variant = 0;
        }
        else
        {
            x_speed = sign(x_speed) * -hurt_speed;
            animation_data.variant = 1;
        }
		
        y_speed = -4;
		
        if (player_index == 0)
        {
            if (shield != SHIELD_TYPE.NONE)
            {
                shield = SHIELD_TYPE.NONE;
            }
            else
            {
                ring_loss = true;
                player_lose_rings();
            }
        }
		
        if (not ring_loss) sound_play(inst != noone and inst.object_index == objSpikes ? sfxSpikesHurt : sfxHurt);
        return player_perform(player_is_hurt);
    }
};

/// @method player_handle_death()
/// @description Sets up how the player death is handled
player_handle_death = function()
{
	if (state_time++ == time_to_frames(0, 1))
	{
		// Check if the player has gotten a time over
		if ((TIME_OVER_ENABLED and ctrlZone.time_over)
		or (GAME_MODE_IS_TIME_ATTACK and ctrlZone.time_over))
		{
			// If the mode is Time Attack
			if (GAME_MODE_IS_TIME_ATTACK)
			{
				// TODO: Reset to a potential Time Attack menu.
			}
			else // Else it is Single/Multi Player
			{
				// Check if the lives system is allowed here
				if (LIVES_ENABLED)
				{
					// Show a Game Over screen depending on certain conditions
					if (global.life_count > 0)
					{
						// When it is Time Over
						return game_over_create(GAME_OVER_TYPE.TIME_UP);
					}
					else
					{
						// When the life count is at *zero*
						return game_over_create(GAME_OVER_TYPE.ZERO_LIVES);
					}
				}
				else
				{
					// Show a Time Over screen
					return game_over_create(GAME_OVER_TYPE.TIME_UP);
				}
			}
		}
		else
		{
			// Reset Ring Count
			global.ring_count = 0;
			
			// If the mode is Time Attack
			if (GAME_MODE_IS_TIME_ATTACK)
			{
				// TODO: Reset to a potential Time Attack menu.
			}
			else // Else it is Single/Multi Player
			{
				// Check if the lives system is allowed here
				if (LIVES_ENABLED)
				{
					// Depending on certain conditions
					if (--global.life_count > 0)
					{
						// Restart the stage
						return room_restart();
					}
					else
					{
						// Show a Game Over screen
						return game_over_create(GAME_OVER_TYPE.ZERO_LIVES);
					}
				}
				else
				{
					// Restart the stage
					return room_restart();
				}
			}
		}
	}
};

/// @method player_speed_break()
/// @description Creates a Speed Break effect.
player_speed_break = function()
{
    with (speed_break)
    {
        var x_scale = other.image_xscale;
        var rot = other.direction;
        time = 0;
        visible = true;
        animation_set(global.ani_speed_break);
        for (var i = 0; i < SPEED_BREAK_COUNT; i++)
        {
            var old_rot, accel;
            positions[i][1] = irandom(4) + 16;
            if (x_scale == -1)
            {
                old_rot = rot + 270;
                positions[i][0] = dcos(rot + 180) * positions[i][1];
                positions[i][1] = -dsin(rot + 180) * positions[i][1];
            }
            else
            {
                old_rot = rot + 90;
                positions[i][0] = dcos(rot) * positions[i][1];
                positions[i][1] = -dsin(rot) * positions[i][1];
            }
            
            accel = irandom(4) + 2;
            accelerations[i][0] = dcos(old_rot) * accel;
            accelerations[i][1] = -dsin(old_rot) * accel;
        }
    }
};

/// @method player_animate()
/// @description Sets the player's current animation.
player_animate = function() {};

/// @method player_draw_before()
/// @description Draws player effects behind the character sprite.
player_draw_before = function() {};

/// @method player_draw_after()
/// @description Draws player effects in front of the character sprite.
player_draw_after = function() {};