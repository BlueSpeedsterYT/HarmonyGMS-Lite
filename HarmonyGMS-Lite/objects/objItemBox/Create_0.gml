/// @description Initialize
// Inherit the parent event
event_inherited();

hitboxes[0].set_size(-13, -27, 13, 1);
icon_offset = 0;
icon_static = false;
frames = 0;
show_itembox = true;
player_index = -1;

// Change Indexes in certain conditions
if ((GAME_MODE_IS_TIME_ATTACK or (not LIVES_ENABLED)) and index == ITEM_INDEX.ONE_UP)
{
	// Not *completely* accurate to the original game
	// but what can you really do.
	instance_destroy();
}
	
if (GAME_MODE_IS_TIME_ATTACK and index == ITEM_INDEX.RINGS_RANDOM)
{
	index = ITEM_INDEX.RINGS_10;
}

itembox_apply_item = function(pla)
{
	switch (index)
	{
		case ITEM_INDEX.ONE_UP:
		{
			pla.player_gain_lives(1);
			break;
		}
		
		case ITEM_INDEX.SHIELD:
		case ITEM_INDEX.SHIELD_MAGNETIC:
		{
			pla.shield.index = index == ITEM_INDEX.SHIELD ? SHIELD.BASIC : SHIELD.MAGNETIC;
			sound_play(sfxShieldGot);
			break;
		}
		
		case ITEM_INDEX.INVINCIBILITY:
		{
			with (pla)
			{
				invincibility_time = INVINCIBILITY_DURATION;
				music_overlay(musInvincibility, true, INVINCIBILITY_DURATION);
			}
			break;
		}
		
		case ITEM_INDEX.SPEED_UP:
		{
			with (pla)
			{
				superspeed_time = SUPERSPEED_DURATION;
				player_refresh_physics();
			}
			break;
		}
		
		case ITEM_INDEX.RINGS_RANDOM:
		{
			pla.player_gain_rings(choose(1, 5, 10, 30, 50));
			sound_play(sfxRing);
			break;
		}
		
		case ITEM_INDEX.RINGS_5:
		{
			pla.player_gain_rings(5);
			sound_play(sfxRing);
			break;
		}
		
		case ITEM_INDEX.RINGS_10:
		{
			pla.player_gain_rings(10);
			sound_play(sfxRing);
			break;
		}
	}
}

reaction = function(pla)
{
	if (collision_player(0, pla))
	{
		if (show_itembox)
		{
			if (can_bounce == true)
			{
				with (pla)
				{
					player_ground(undefined);
					y_speed = -3;
					animation_play(PLAYER_ANIMATION.SPRING, 0);
					player_perform(player_is_falling, false);
				}
			}
			pla.aerial_flags = 0;
			pla.player_refresh_aerials();
			sound_play(sfxItemBoxBreak);
			particle_create(x, y, global.ani_dust_cloud_v0);
			frames = 0;
			player_index = pla;
			show_itembox = false;
		}
	}
}