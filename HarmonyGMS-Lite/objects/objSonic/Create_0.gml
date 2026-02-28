/// @description Initialize
// Inherit the parent event
event_inherited();

character_index = CHARACTER.SONIC;

trick_speed =
[
    [0, -6],
    [0, 1],
    [6, 0],
    [-5, -3.5]
];

insta_shield = new stamp();
trick_spin = new stamp();

player_animate = function()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            player_set_animation(global.ani_sonic_idle_v0);
            image_angle = gravity_direction;
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            player_set_animation(global.ani_sonic_turn);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            player_animate_run(global.ani_sonic_run);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            player_set_animation(global.ani_sonic_brake);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-6, -13, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -13, 6, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.APPEAL:
        {
            player_set_animation(global.ani_sonic_appeal);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -13, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        { 
            player_set_animation(global.ani_sonic_crouch);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -6, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.ROLL:
        {
            player_set_animation(global.ani_sonic_roll_v0, 0);
            player_set_radii(6, 9);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-8, -8, 8, 8);
                hitboxes[1].set_size(-8, -8, 8, 8);
            }
            break;
        }
        case PLAYER_ANIMATION.SPIN_DASH:
        {
            if (animation_data.variant == 1 and animation_is_finished()) animation_data.variant = 0;
            player_set_animation(global.ani_sonic_spin_dash);
            player_set_radii(6, 9);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -8, 6, 8);
                hitboxes[1].set_size(-8, -8, 8, 8);
            }
            break;
        }
        case PLAYER_ANIMATION.FALL:
        {
            player_animate_fall(global.ani_sonic_fall);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 14);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.JUMP:
        {
            player_animate_jump(global.ani_sonic_jump);
            switch (animation_data.variant)
            {
                case 0:
                {
                    player_set_radii(6, 14);
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 16);
                        hitboxes[1].set_size(-6, -16, 6, 16);
                    }
                    break;
                }
                case 1:
                {
                    player_set_radii(6, 9);
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-8, -8, 8, 8);
                        hitboxes[1].set_size(-8, -8, 8, 8);
                    }
                    break;
                }
                case 2:
                {
                    player_set_radii(6, 9);
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 4);
                        hitboxes[1].set_size(-8, -10, 8, 14);
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.HURT:
        {
            player_set_animation(global.ani_sonic_hurt);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -8, 6, 24);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.DEAD:
        {
            player_set_animation(global.ani_sonic_dead_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size();
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_UP:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            player_set_animation(global.ani_sonic_trick_up);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 14);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_DOWN:
        {
            player_set_animation(global.ani_sonic_trick_down);
            player_set_radii(6, 9);
            switch (animation_data.variant)
            {
                case 0:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 14);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 5:
                        {
                            hitboxes[0].set_size(-8, -8, 8, 8);
                            hitboxes[1].set_size(-8, -8, 8, 8);
                            break;
                        }
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-8, -8, 8, 8);
                        hitboxes[1].set_size(-8, -8, 8, 8);
                    }
                    break;
                }
                case 2:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 14);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_FRONT:
        {
            player_set_animation(global.ani_sonic_trick_front);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 8, 14);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 14);
                        hitboxes[1].set_size(-14, -16, 14, 14);
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_BACK:
        {
            player_set_animation(global.ani_sonic_trick_back);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 14);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.SPRING:
        {
            player_animate_spring(global.ani_sonic_spring);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 14);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.SPRING_TWIRL:
        {
            player_set_animation(global.ani_sonic_spring_twirl_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -16, 6, 14);
                hitboxes[1].set_size();
            }
            break;
        }
		case PLAYER_ANIMATION.DASH:
		{
			player_set_animation(global.ani_sonic_dash);
			player_set_radii(6, 14);
			switch (animation_data.variant)
			{
				case 0:
				{
					switch (image_index)
					{
						case 0:
						{
							hitboxes[0].set_size(-8, -14, 8, 18);
							hitboxes[1].set_size();
							break;
						}
						case 1:
						{
							hitboxes[0].set_size(-8, -16, 8, 14);
							hitboxes[1].set_size();
							break;
						}
					}
					break;
				}
				case 1:
				{
					if (image_index == 0)
		            {
		                hitboxes[0].set_size(-6, -16, 6, 14);
						hitboxes[1].set_size();
		            }
					break;
				}
			}
			break;
		}
		case SONIC_ANIMATION.INSTA_SHIELD:
		{
			player_set_animation(global.ani_sonic_insta_shield_v0);
			player_set_radii(6, 9);
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(-8, -8, 8, 8);
					hitboxes[1].set_size(-14, -14, 14, 14);
					break;
				}
				
				case 8:
				{
					// yea i dunno why either
					hitboxes[0].set_size(-8, -8, 8, 8);
					break;
				}
			}
			break;
		}
		case SONIC_ANIMATION.FORWARD_THRUST:
		{
			player_set_animation(global.ani_sonic_thrust_v0);
			player_set_radii(6, 9);
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(-6, -12, 6, 18);
					hitboxes[1].set_size();
					break;
				}
				
				case 4:
				{
					hitboxes[0].set_size(-6, -14, 8, 16);
					break;
				}
			}
			break;
		}
		case SONIC_ANIMATION.SKIDDING:
		{
			player_set_animation(global.ani_sonic_skidding);
			player_set_radii(6, 9);
			switch (animation_data.variant)
			{
				case 0:
				{
					switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -6, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-16, -6, 10, 10);
                            hitboxes[1].set_size(-16, -20, 23, 16);
                            break;
                        }
                    }
                    break;
				}
				case 1:
				{
					if (image_index == 0)
		            {
		                hitboxes[0].set_size(-14, -2, 14, 16);
						hitboxes[1].set_size(-3, -8, 21, 18);
		            }
					break;
				}
				case 2:
				{
					if (image_index == 0)
		            {
		                hitboxes[0].set_size(-16, -6, 6, 6);
		                hitboxes[1].set_size();
		            }
					break;
				}
			}
			break;
		}
    }
};

player_draw_after = function()
{
	with (trick_spin) draw_self_floored();
	with (insta_shield) draw_self_floored();
};