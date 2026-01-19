/// @description Setup
// Inherit the parent event
event_inherited();

character_index = CHARACTER.KNUCKLES;

glide_speed = 0;
glide_angle = 0;
glide_direction = 1;

trick_speed =
[
    [0, -6],
    [0, 1],
    [6, 0],
    [-5, -0]
];

player_try_skill = function()
{
    if (not on_ground)
    {
		if (input_button.attack.pressed)
        {
            // Drill Claw
			player_perform(knuckles_is_preparing_drill_clawing)
			return true;
        }
		else if (input_button.jump.pressed)
        {
			// Glide
			// Unlike Sonic 3 for some reason, Knuckles can not glide underwater. Like at all.
			// Maybe it's done to save on power and math on how his gliding works?
			// SA1 allows him to float above water so I dunno...
			player_perform(knuckles_is_gliding)
			return true;
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
            player_set_animation(global.ani_knuckles_idle_v0);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -14, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.TEETER:
        {
            player_animate_teeter(global.ani_knuckles_teeter);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-5, -14, 7, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -14, 6, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TURN:
        {
            player_set_animation(global.ani_knuckles_turn);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -14, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.RUN:
        {
            player_animate_run(global.ani_knuckles_run);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -14, 6, 16);
                hitboxes[1].set_size();
            }
            break;
        }
        case PLAYER_ANIMATION.BRAKE:
        {
            player_set_animation(global.ani_knuckles_brake);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -14, 6, 16);
                        hitboxes[1].set_size();
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
        case PLAYER_ANIMATION.LOOK:
        {
            player_set_animation(global.ani_knuckles_look);
            player_set_radii(6, 14);
            if (image_index == 0)
            {
                hitboxes[0].set_size(-6, -14, 6, 16);
                hitboxes[1].set_size();
            }
            
            break;
        }
        case PLAYER_ANIMATION.CROUCH:
        {
            player_set_animation(global.ani_knuckles_crouch);
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
            player_set_animation(global.ani_knuckles_roll_v0, 0);
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
            player_set_animation(global.ani_knuckles_spin_dash);
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
            player_animate_fall(global.ani_knuckles_fall);
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
            player_animate_jump(global.ani_knuckles_jump);
            switch (animation_data.variant)
            {
                case 0:
                {
                    player_set_radii(6, 14);
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 6, 18);
                        hitboxes[1].set_size(-6, -12, 6, 18);
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
            player_set_animation(global.ani_knuckles_hurt);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -14, 6, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -6, 6, 24);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.DEAD:
        {
            player_set_animation(global.ani_knuckles_dead_v0);
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
            player_set_animation(global.ani_knuckles_trick_up);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                case 2:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 14);
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
                            hitboxes[0].set_size(-6, -16, 6, 14);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 2:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 14);
                            hitboxes[1].set_size(-14, -28, 14, -2);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_DOWN:
        {
            player_set_animation(global.ani_knuckles_trick_down);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 14);
                        hitboxes[1].set_size();
                    }
                    break;
                }
                case 1:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -12, 6, 18);
                        hitboxes[1].set_size(-14, 0, 14, 30);
                    }
                    break;
                }
                case 2:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -14, 6, 16);
                        hitboxes[1].set_size();
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_FRONT:
        {
            player_set_animation(global.ani_knuckles_trick_front);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -14, 6, 16);
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
                            hitboxes[0].set_size(-6, -14, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 3:
                        {
                            hitboxes[0].set_size(-14, -9, 14, 6);
                            hitboxes[1].set_size(4, -16, 19, 14);
                            break;
                        }
                    }
                    break;
                }
                case 2:
                {
                    switch (image_index)
                    {
                        case 0:
                        {
                            hitboxes[0].set_size(-6, -14, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 3:
                        {
                            hitboxes[0].set_size(-8, -8, 8, 8);
                            hitboxes[1].set_size(-8, -8, 8, 8);
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
        case PLAYER_ANIMATION.TRICK_BACK:
        {
            player_set_animation(global.ani_knuckles_trick_back);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -14, 6, 16);
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
                            hitboxes[0].set_size(-6, -14, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 2:
                        {
                            hitboxes[0].set_size(-6, -16, 6, 14);
                            hitboxes[1].set_size(-18, -16, 0, 14);
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
            player_set_animation(global.ani_knuckles_spring);
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
            player_set_animation(global.ani_knuckles_spring_twirl_v0);
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
			player_set_animation(global.ani_knuckles_dash);
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
							hitboxes[0].set_size(-8, -15, 8, 14);
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
		case PLAYER_ANIMATION.GLIDE:
		{
			player_set_animation(global.ani_knuckles_glide_v0);
			player_set_radii(6, 6);
			if (image_index == 0)
            {
                hitboxes[0].set_size(-16, -8, 6, 6);
                hitboxes[1].set_size(-2, -12, 15, 9);
            }
			break;
		}
		case PLAYER_ANIMATION.GLIDE_TURN:
		{
			player_set_animation(global.ani_knuckles_glide_turn);
			player_set_radii(6, 6);
			switch (animation_data.variant)
			{
				case 0:
				{
					if (image_index == 0)
		            {
		                hitboxes[0].set_size(-6, -8, 16, 6);
		                hitboxes[1].set_size(-2, -12, 12, 9);
		            }
					break;
				}
				case 1:
				{
					if (image_index == 0)
		            {
		                hitboxes[0].set_size(-10, -8, 12, 6);
						hitboxes[1].set_size(2, -12, 16, 9);
		            }
					break;
				}
				case 2:
				{
					if (image_index == 0)
		            {
		                hitboxes[0].set_size(-14, -8, 8, 6);
		                hitboxes[1].set_size(-16, -12, -2, 9);
		            }
					break;
				}
				case 3:
				{
					if (image_index == 0)
		            {
		                hitboxes[0].set_size(-18, -8, 4, 6);
		                hitboxes[1].set_size(-12, -12, 2, 9);
		            }
					break;
				}
			}
			break;
		}
		case PLAYER_ANIMATION.GLIDE_SLIDING:
		{
			player_set_animation(global.ani_knuckles_glide_sliding_v0);
			player_set_radii(6, 6);
			if (image_index == 0)
            {
                hitboxes[0].set_size(-19, -6, 5, 7);
                hitboxes[1].set_size(-2, -10, 11, 10);
            }
			break;
		}
		case PLAYER_ANIMATION.GLIDE_FALL:
        {
            player_set_animation(global.ani_knuckles_glide_falling);
            player_set_radii(6, 14);
            switch (animation_data.variant)
            {
                case 0:
                {
                    if (image_index == 0)
                    {
                        hitboxes[0].set_size(-6, -16, 6, 14);
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
                            hitboxes[0].set_size(-6, -16, 6, 14);
                            hitboxes[1].set_size();
                            break;
                        }
                        case 2:
                        {
                            hitboxes[0].set_size(-6, -6, 6, 16);
                            hitboxes[1].set_size();
                            break;
                        }
                    }
                    break;
                }
            }
            break;
        }
    }
};