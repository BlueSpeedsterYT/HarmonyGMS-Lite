/// @description Stamps
if (ctrlGame.game_paused) exit;

// Inherit the parent event
event_inherited();

// Trick Spin
with (trick_spin)
{
	var is_trick_front_spinning_ani = (other.animation_data.index == PLAYER_ANIMATION.TRICK_FRONT and other.animation_data.variant == 1)
	if (is_trick_front_spinning_ani)
    {
        x = other.x div 1;
        y = other.y div 1;
        image_xscale = other.image_xscale;
        
        animation_set(global.ani_sonic_trick_front_v2);
    }
    else if (not is_undefined(animation_data.ani))
    {
        animation_set(undefined);
    }
}

// Insta-Shield
with (insta_shield)
{
    if (animation_is_finished())
    {
        animation_set(undefined);
    }
	else
	{
		x = other.x div 1;
		y = other.y div 1;
		depth = other.depth;
		image_xscale = other.image_xscale;
		image_angle = other.image_angle;
	}
}