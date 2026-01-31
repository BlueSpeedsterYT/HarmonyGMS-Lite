/// @description Initialize
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-13, -27, 13, 1);
no_player_break_recoil = false;

// Change Indexes in Time Attack Modes
if (GAME_MODE_IS_TIME_ATTACK)
{
	if (index == ITEM_INDEX.ONE_UP)
	{
		// Not *completely* accurate to the original game
		// but what can you really do.
		instance_destroy();
	}
	
	if (index == ITEM_INDEX.RINGS_RANDOM)
	{
		index = ITEM_INDEX.RINGS_10;
	}
}

collide_with_itembox = function(pla)
{
	var hitbox_flag = collision_player_itembox(id, pla);
	if (pla.state != player_is_dead)
	{
		if (hitbox_flag == true)
		{
			no_player_break_recoil = true;
			return no_player_break_recoil;
		}
		else
		{
			if (not collision_player(0, pla, 1))
			{
				return false;
			}
			else
			{
				no_player_break_recoil = false;
				return true;
			}
		}
	}
	else
	{
		return false;
	}
}

break_itembox = function(pla)
{
	if (no_player_break_recoil == false or (not pla.on_ground))
	{
		with (pla)
		{
			y_speed = -3;
			animation_play(PLAYER_ANIMATION.SPRING, 0);
			player_perform(player_is_sprung);
		}
	}
	
	sound_play(sfxItemBoxBreak);
	
	// TODO: Add Effect
}

reaction = function(pla)
{
	// Abort if the player is considered *dead*
	if (pla.state == player_is_dead) exit;
	
	if (collide_with_itembox(pla))
	{
		break_itembox(pla);
	}
}