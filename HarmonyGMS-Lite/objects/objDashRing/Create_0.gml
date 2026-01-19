/// @description Setup
// Inherit the parent event
event_inherited();

active = 0;

reaction = function(pla)
{
    if (pla.state == player_is_dead) exit;
	
	var bit = 1 << pla.player_index;
    if (collision_player(0, pla))
    {
        if (active & bit == 0)
        {
            var diff = angle_wrap(direction - pla.gravity_direction);
            pla.x = x;
			pla.y = y;
			if (diff != 0 and diff != 180)
			{
				with (pla)
				{
					animation_init(PLAYER_ANIMATION.SPRING, (diff >= 45 and diff <= 135) ? 0 : 1);
					player_perform(player_is_sprung);
				}
			}
			else
			{
				pla.player_perform(player_is_dashing);
			}
			if (dcos(diff) != 0) pla.image_xscale = sign(dcos(diff));
			pla.x_speed = dcos(diff) * 8;
            pla.y_speed = -dsin(diff) * 8;
			pla.state_time = 16;
			pla.player_refresh_aerial_skills();
            active |= bit;
			sound_play(sfxDashRing);
        }
    }
    else 
    {
        active &= ~bit;
    }
};