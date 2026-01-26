/// @description Behave
if (ctrlGame.game_paused) exit;

// Input
if (input_allow and (player_index == 0))
{
	input_axis_x = InputOpposing(INPUT_VERB.LEFT, INPUT_VERB.RIGHT, player_index);
	input_axis_y = InputOpposing(INPUT_VERB.UP, INPUT_VERB.DOWN, player_index);
    
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

x_speed = clamp(x_speed, -max_speed, max_speed);

with (shield)
{
    var invincible = (other.invincibility_time > 0);
    if (index != SHIELD.NONE or invincible)
    {
        var x_int = other.x div 1;
        var y_int = other.y div 1;
        x = x_int;
        y = y_int;
        
        var shield_advance = (index == SHIELD.BASIC or index == SHIELD.MAGNETIC or invincible);
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
            case SHIELD.BASIC:
            {
                animation_set(global.ani_shield_basic_v0);
                break;
            }
            case SHIELD.MAGNETIC:
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
