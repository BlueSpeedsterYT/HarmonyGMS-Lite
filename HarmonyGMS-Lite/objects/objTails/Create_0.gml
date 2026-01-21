/// @description Setup
// Inherit the parent event
event_inherited();

character_index = CHARACTER.TAILS;

fly_time = -1;
fly_force = TAILS_FLY_BASE_FORCE;
fly_state_time = 0;
fly_sound = noone;

trick_speed =
[
    [0, -6],
    [0, 0.5],
    [4, -2.5],
    [-3.5, -3]
];

tails = new stamp();

player_try_skill = function()
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
			fly_time = TAILS_FLIGHT_DURATION;
			fly_state_time = 1; 
			player_perform(tails_is_flying);
			return true;
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
			return true;
		}
	}
    return false;
};

player_animate = function()
{
    switch (animation_data.index)
    {
        case PLAYER_ANIMATION.IDLE:
        {
            player_set_animation(global.ani_tails_idle_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TEETER:
        {
            player_animate_teeter(global.ani_tails_teeter);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            player_set_animation(global.ani_tails_turn);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            player_animate_run(global.ani_tails_run);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            player_set_animation(global.ani_tails_brake);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.LOOK:
        {
            player_set_animation(global.ani_tails_look);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        {
            player_set_animation(global.ani_tails_crouch);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -4, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.ROLL:
        {
            player_set_animation(global.ani_tails_roll_v0, 0);
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
            player_set_animation(global.ani_tails_spin_dash);
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
            player_animate_fall(global.ani_tails_fall);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 12);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.JUMP:
        {
            player_animate_jump(global.ani_tails_jump);
            switch (animation_data.variant)
            {
                case 0:
                {
                    player_set_radii(6, 14);
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -18, 6, 4);
                            hitboxes[1].set_size(-6, -18, 6, 4);
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-7, -6, 5, 16);
                            hitboxes[1].set_size(-7, -6, 5, 16);
                            break;
                        }
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
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 6);
                            hitboxes[1].set_size(-10, -8, 10, 12);
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-6, -18, 8, 4);
                            hitboxes[1].set_size(-9, -9, 9, 9);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.HURT:
        {
            player_set_animation(global.ani_tails_hurt);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 10, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-8, -9, 8, 19);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.DEAD:
        {
            player_set_animation(global.ani_tails_dead_v0);
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
            player_set_animation(global.ani_tails_trick_up);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 10);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_DOWN:
        {
            player_set_animation(global.ani_tails_trick_down);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 10);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_FRONT:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            player_set_animation(global.ani_tails_trick_front);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -12, 6, 10);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_BACK:
        {
            if (animation_data.variant == 1 and y_speed > 0) animation_data.variant = 2;
            player_set_animation(global.ani_tails_trick_back);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                    case 2:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 6, 10);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 10);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 3:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 10);
                            hitboxes[1].set_size(-23, 0, 14, 10);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.SPRING:
        {
            player_set_animation(global.ani_tails_spring);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 6, 10);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -12, 6, 10);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 1:
                        {
                            hitboxes[0].set_size(-6, -14, 6, 8);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 4:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 6);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 5:
                        {
                            hitboxes[0].set_size(-6, -14, 6, 6);
                            hitboxes[1].set_size();
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    hitboxes[0].set_size(-6, -16, 6, 6);
                    hitboxes[1].set_size();
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.SPRING_TWIRL:
        {
            player_set_animation(global.ani_tails_spring_twirl_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -11, 6, 11);
                hitboxes[1].set_size();
            }
            break;
        }
		case PLAYER_ANIMATION.DASH:
		{
			player_set_animation(global.ani_tails_dash);
			player_set_radii(6, 14);
			switch (animation_data.variant)
			{
				case 0:
				{
					switch (image_index)
					{
						case 0:
						{
							hitboxes[0].set_size(-6, -10, 6, 16);
							hitboxes[1].set_size();
							break;
						}
						case 1:
						{
							hitboxes[0].set_size(-6, -10, 6, 12);
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
		                hitboxes[0].set_size(-6, -10, 6, 12);
						hitboxes[1].set_size();
		            }
					break;
				}
			}
			break;
		}
		case TAILS_ANIMATION.FLYING:
		{
			player_set_animation(global.ani_tails_flying_v0);
            player_set_radii(6, 14);
			if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 10);
                hitboxes[1].set_size(-22, -23, 21, -11);
            }
			break;
		}
		case TAILS_ANIMATION.FLYING_TURN:
		{
			player_set_animation(global.ani_tails_flying_turn_v0);
            player_set_radii(6, 14);
			if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -10, 6, 10);
                hitboxes[1].set_size(-17, -19, 17, -11);
            }
			break;
		}
		case TAILS_ANIMATION.FLYING_TIRED:
		{
			player_set_animation(global.ani_tails_flying_tired_v0);
            player_set_radii(6, 14);
			switch (image_index)
            {
                case 0:
                {
                    hitboxes[0].set_size(-6, -10, 6, 10);
                    hitboxes[1].set_size();
                    break;
                }
                case 2:
                {
                    hitboxes[0].set_size(-6, -10, 6, 10);
                    hitboxes[1].set_size();
                    break;
                }
			}
			break;
		}
    }
};

player_draw_before = function()
{
    tails.image_alpha = image_alpha;
    with (tails) draw_self_floored();
};