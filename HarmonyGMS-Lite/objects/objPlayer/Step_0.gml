/// @description Behave
if (ctrlGame.game_paused) exit;

// Boost Mode
player_refresh_boost_mode();

// Input
if (input_allow and (player_index == 0))
{
	input_axis_x = InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, player_index);
	input_axis_pressed_x = InputOpposingPressed(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, player_index);
	input_axis_y = InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN, player_index);
	input_axis_pressed_y = InputOpposingPressed(INPUT_VERB.UP, INPUT_VERB.DOWN, player_index);
    
	input_double_tap_timer_x++;
	input_double_tap_timer_y++;
	
	// Horizontal Double Tap Inputs
	if (input_axis_pressed_x != 0)
	{
		if (input_double_tap_timer_x > 3 and input_double_tap_timer_x < 13)
		{
			input_double_tap_direction_x = (input_axis_pressed_x == -1) ? -1 : 1;
			input_double_tap_timer_x = 0;
		}
		else if (input_double_tap_timer_x > 0)
		{
			input_double_tap_timer_x = 0;
		}
	}
	
	// Vertical Double Tap Inputs
	if (input_axis_pressed_y != 0)
	{
		if (input_double_tap_timer_y > 3 and input_double_tap_timer_y < 13)
		{
			input_double_tap_direction_y = (input_axis_pressed_y == -1) ? -1 : 1;
			input_double_tap_timer_y = 0;
		}
		else if (input_double_tap_timer_y > 0)
		{
			input_double_tap_timer_y = 0;
		}
	}
	
	struct_foreach(input_button, function(name, value)
	{
		var verb = value.verb;
		value.check = InputCheck(verb, player_index);
		value.pressed = InputPressed(verb, player_index);
		value.released = InputReleased(verb, player_index);
	});
	
	// Enter Debug
	if (DEBUG_ENABLED and input_button.select.pressed)
	{
		player_perform((state != player_is_debugging) ? player_is_debugging : player_is_falling);
	}
};

if (script_exists(state)) 
{
    state(PHASE.STEP);
    if (state_changed) state_changed = false;
}
player_animate();

// Spin Dash Dust
with (spin_dash_dust)
{
    var action = other.state;
    if (action == player_is_spin_dashing)
    {
        var x_int = other.x div 1;
        var y_int = other.y div 1;
        var sine = dsin(other.gravity_direction);
        var cosine = dcos(other.gravity_direction);
        var charge = floor(other.spin_dash_charge);
        x = x_int + sine * other.y_radius;
        y = y_int + cosine * other.y_radius;
        image_xscale = other.image_xscale;
        image_angle = other.mask_direction;
        animation_data.variant = (charge > 2);
        animation_set(global.ani_spin_dash_dust);
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

// Shield
with (shield)
{
    var invincible = (other.invincibility_time > 0);
    if (index != SHIELD_TYPE.NONE or invincible)
    {
        x = other.x div 1;
        y = other.y div 1;
        
        var shield_advance = (index == SHIELD_TYPE.BASIC or index == SHIELD_TYPE.MAGNETIC or invincible);
        animation_play(invincible ? -1 : index);
        switch (animation_data.index)
        {
            case -1:
            {
                animation_set(global.ani_shield_invincibility_v0);
                if (animation_data.time mod 8 == 0)
                {
                    var x_off = irandom_range(-16, 16);
                    var y_off = irandom_range(-16, 16);
                    particle_create(x + x_off, y + y_off, global.ani_shield_invincibility_sparkle_v0);
                }
                break;
            }
            case SHIELD_TYPE.BASIC:
            {
                animation_set(global.ani_shield_basic_v0);
                break;
            }
            case SHIELD_TYPE.MAGNETIC:
            {
                animation_set(global.ani_shield_magnetic_v0);
                break;
            }
        }
        
        // Visible
        visible = (shield_advance) ? animation_data.time mod 4 < 2 : true;
        
        image_xscale = 1;
        image_angle = other.gravity_direction;
        image_alpha = 1;
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

// Speed Break
with (speed_break)
{
    if (visible)
    {
        x = other.x div 1;
        y = other.y div 1;
        
        switch (animation_data.variant)
        {
            case 1:
            {
                if (time++ > 24)
                {
                    visible = false;
                    animation_set(undefined);
                    break;
                }
                
                for (var i = 0; i < SPEED_BREAK_COUNT; i++)
                {
                    positions[i][0] += accelerations[i][0];
                    positions[i][1] += accelerations[i][1];
                    
                    positions[i][0] -= unkE2;
                    positions[i][1] -= unkE4;
                    
                    accelerations[i][0] *= 0.78125;
                    accelerations[i][1] *= 0.78125;
                    
                    unkE2 *= 1.00390625;
                    unkE4 *= 1.00390625;
                }
                break;
            }
            default:
            {
                for (var i = 0; i < SPEED_BREAK_COUNT / 2; i++)
                {
                    if (i & 1)
                    {
                        positions[i][0] += accelerations[i][0];
                        positions[i][1] += accelerations[i][1];
                    }
                    else
                    {
                        positions[i][0] -= accelerations[i][0];
                        positions[i][1] -= accelerations[i][1];
                    }
                    
                    accelerations[i][0] *= 0.78125;
                    accelerations[i][1] *= 0.78125;
                }
                
                if (time++ > 8)
                {
                    var x_scale = other.image_xscale;
                    var rot = other.direction;
                    animation_data.variant = 1;
                    animation_set(global.ani_speed_break);
                    for (var i = 0; i < SPEED_BREAK_COUNT; i++)
                    {
                        var rand_rot = irandom(359);
                        if (x_scale == -1)
                        {
                            rand_rot += 90;
                            unkE2 = dcos(rot + 180) * 4;
                            unkE4 = -dsin(rot + 180) * 4;
                        }
                        else
                        {
                            unkE2 = dcos(rot) * 4;
                            unkE4 = -dsin(rot) * 4;
                        }
                        
                        var accel = irandom(4) + 6;
                        accelerations[i][0] = dcos(rand_rot) * accel;
                        accelerations[i][1] = -dsin(rand_rot) * accel;
                    }
                }
            }
        }
    }
}

// Afterimages
player_refresh_animation_history();

afterimage_visible = boost_mode;
if (afterimage_visible)
{
	for (var i = 0; i < AFTERIMAGE_COUNT; i++)
	{
	    var delay = i * 2 + 2;
        var history_index = modwrap(animation_history_index - delay, 0, ANIMATION_RECORD_COUNT);
        var record = animation_history[history_index];
        with (afterimage_list[i])
        {
            x = record.x;
            y = record.y;
            image_xscale = record.image_xscale;
            image_yscale = record.image_yscale;
            image_angle = record.image_angle;
            animation_set(record.ani);
            animation_data.speed = record.ani_speed;
        }
	}
}