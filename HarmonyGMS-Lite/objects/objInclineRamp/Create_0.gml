/// @description Initialize
event_inherited();
active = 0;
hitboxes[0].set_size(0, 0, sprite_width, sprite_height);
reaction = function (pla)
{
	var bit = 1 << pla.player_index;
    if (not pla.on_ground) exit;
	if (collision_player(0, pla))
    {
        if (active & bit == 0)
        {
            if (ramp_mode == 0)
			{
				if (pla.x_speed > 4)
	            {
					with (pla)
					{
						x_speed += 3;
						y_speed = -17;
						animation_init(PLAYER_ANIMATION.SPRING_TWIRL, 0);
						player_perform(player_is_sprung);
					}
					pla.aerial_flags = 0;
					pla.player_refresh_aerials();
		            active |= bit;
		            sound_play(sfxSpring);
				}
			}
			else
			{
				if (pla.x_speed < -4)
				{
					with (pla)
					{
						x_speed += -3;
						y_speed = -17;
						// NOTE: Needs a different jumping animation but for now,
						// set it as the default jumping animation.
						animation_init(PLAYER_ANIMATION.JUMP, 0);
						player_perform(player_is_sprung);
					}
					pla.aerial_flags = 0;
					pla.player_refresh_aerials();
					active |= bit;
		            sound_play(sfxSpring);
				}
			}
        }
    }
    else 
    {
        active &= ~bit;
    }
};