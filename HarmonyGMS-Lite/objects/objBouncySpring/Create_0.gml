/// @description Initialize
// Inherit the parent event
event_inherited();

active = 0;
animation_data = new animation_core();
ani_spring = global.ani_spring_bouncy;
hitboxes[0].set_size(-5, -21, 5, 0);

reaction = function(pla)
{
    var bit = 1 << pla.player_index;
	var ani_spring = PLAYER_ANIMATION.SPRING;
    if (collision_player(0, pla))
    {
        if (active & bit == 0)
        {
			with (pla)
			{
				animation_play(ani_spring, 0);
				player_perform(player_is_sprung);
			}
			var stored_y_speed = pla.y_speed;
			var index = ((stored_y_speed * 256) / 400) div 1;
			index = clamp(index, 1, 3);
			var force = (stored_y_speed + (stored_y_speed / 8));
            pla.y_speed = -force;
			pla.y_speed = clamp(pla.y_speed, -12.0, -7.5);
            pla.state_time = 3;
			pla.aerial_flags = 0;
			pla.player_refresh_aerials();
            active |= bit;
            animation_data.variant = index;
            // TODO: SA2 uses a different sound for the bouncy springs so use that
			// NOTE: SA2 has two different bouncy sounds, one for the pole, the other for the spring.
			// gonna have to figure out how to record sounds like that in SA2
			//sound_play(sfxSpring);
        }
    }
    else 
    {
        active &= ~bit;
    }
};