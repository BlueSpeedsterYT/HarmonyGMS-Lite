/// @description Actions

/// @description Checks if the player can perform a ground skill.
/// @returns {Bool}
player_check_ground_skill = function()
{
    return (on_ground and not (local_direction >= 90 and local_direction <= 270));
};

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

/// @description Sets the player's current state to either crouching or rolling, if applicable.
/// @returns {Bool}
player_try_crouch_or_roll = function()
{
	if (input_axis_y == 1)
	{
		// Crouch
		if (x_speed == 0 and mask_direction == gravity_direction)
		{
			player_perform(player_is_crouching);
			animation_play(PLAYER_ANIMATION.CROUCH);
			return true;
		}
		// Roll
		else if ((abs(x_speed) + (0.5 - (1 / 256))) > ROLL_THRESHOLD)
		{
			sound_play(sfxRoll);
			player_perform(player_is_rolling);
			animation_play(PLAYER_ANIMATION.ROLL);
			return true;
		}
	}
	return false;
};

/// @desctiption Sets the player's current state to tricking, if applicable.
/// @param [time] Time to check (optional, defaults to 0).
/// @returns {Bool}
player_try_trick_action = function(time = 0)
{
	if (input_button.trick.pressed)
	{
		if (time == 0)
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
	}
	return false;
};

/// @description Checks if the player performs a character skill.
/// @returns {Bool}
player_try_skill = function()
{
	if (player_index == 0)
	{
		switch (object_index)
		{
			case objSonic:
			{
				if (not on_ground)
				{
					if (input_axis_pressed_x != 0 and sign(input_double_tap_direction_x) == image_xscale)
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
				
					if (input_button.jump.pressed)
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
				
					if (input_button.attack.pressed)
					{
						// Bound
						player_perform(sonic_is_preparing_bound);
						return true;
					}
				}
				else
				{
					if (input_button.attack.pressed and player_check_ground_skill())
					{
						// Skid Attack
						// Sonic's skid attack is simple and effective, however
						// it gets supercharged while in boost mode, the skys the limit with this power.
						// so use it wisely.
						player_perform(sonic_is_skidding);
						return true;
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
						if (state != tails_is_flying and fly_time < TAILS_FLY_DURATION)
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
					if (input_button.attack.pressed and player_check_ground_skill())
					{
						// Tail Swipe
						// it is a swiping attack.
						player_perform(tails_is_tail_swipe);
						return true;
					}
				}
				break;
			}
			case objKnuckles:
			{
				if (not on_ground)
				{
					if (input_button.jump.pressed)
					{
						// Glide
						// Unlike Sonic 3 for some reason, Knuckles can not glide underwater. Like at all.
						// Maybe it's done to save on power and math on how his gliding works?
						// SA1 allows him to float above water so I dunno...
						player_perform(knuckles_is_gliding);
						return true;
					}
				
					if (input_button.attack.pressed)
					{
						// Drill Claw
						if (state != knuckles_is_preparing_drill_clawing)
						{
							player_perform(knuckles_is_preparing_drill_clawing);
							return true;
						}
					}
				}
				else
				{
					if (input_button.attack.pressed and player_check_ground_skill())
					{
						// Punch/Spiral Attack
						// If the player is not in boost mode, then Knuckles would do a simple punch.
						// however, that punch turns into a spiral strike when in boost mode.
						// Be noteful on how you handle that.
						player_perform((not boost_mode) ? knuckles_is_punching_left : knuckles_is_sprial_attack);
						return true;
					}
				}
				break;
			}
		}
	}
	
	return false;
}

/// @description Resets aerial character skills when grounded.
player_refresh_aerials = function() 
{
	switch (object_index)
	{
		case objTails:
		{
			if (on_ground) fly_time = 0;
			break;
		}
	}
};

/// @description Evaluates the player's condition after taking a hit.
/// Setting inst to the player's id will force a death, while setting it to noone will just hurt the player.
/// @param {Id.Instance} inst Instance to check.
player_damage = function(inst)
{
    // Abort if the player is already dead or hurt
    if (state == player_is_dead or ((state == player_is_hurt or recovery_time > 0 or invincibility_time > 0) and inst != id)) exit;
    
    if (inst == id or (player_index == 0 and shield.index == SHIELD_TYPE.NONE and global.ring_count == 0))
    {
        y_speed = -4.875;
        sound_play(sfxHurt);
        return player_perform(player_is_dead);
    }
    else
    {
    	var hurt_speed = -1.5;
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
		
        y_speed = -3;
		
        if (player_index == 0)
        {
            if (shield != SHIELD_TYPE.NONE)
            {
                shield = SHIELD_TYPE.NONE;
            }
            else
            {
                ring_loss = true;
                player_drop_rings();
            }
        }
		
        if (not ring_loss) sound_play(inst != noone and inst.object_index == objSpikes ? sfxSpikesHurt : sfxHurt);
        return player_perform(player_is_hurt);
    }
};