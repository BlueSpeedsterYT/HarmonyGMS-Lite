/// @description Behave

switch (state)
{
	case 0:
	{
		// Fade out.
		if (delay != 0) 
		{
			delay--;
		}
		else
		{
			if (game_over_cause == GAME_OVER_TYPE.ZERO_LIVES)
			{
				music_clear();
				music_enqueue(musGameOver, PRIORITY_MUSIC, false);
			}
			else
			{
				sound_play(sfxTimeOver);
			}
			state++;
		}
		break;
	}
	case 1:
	{
		if (game_over_cause == GAME_OVER_TYPE.ZERO_LIVES)
		{
			if (frames_until_done > GAME_OVER_FADE_1_X)
			{
				left_x = frames_until_done + 60;
				right_x = frames_until_done + 60;
			}
			else
			{
				left_x = CAMERA_WIDTH_CENTER;
				right_x = CAMERA_WIDTH_CENTER;
			}
			
			if (--frames_until_done == GAME_OVER_END_X)
			{
				frames_until_done = CAMERA_WIDTH_CENTER;
				state++;
			}
		}
		else
		{
			if (--frames_until_done == TIME_OVER_END_X)
			{
				global.ring_count = 0;
				if (ctrlGame.game_mode == GAME_MODE.TIME_ATTACK)
				{
					// TODO: Reset to a potential Time Attack menu.
				}
				else
				{
					room_restart();
				}
				return;
			}
			
			update_time_over_text();
		}
		break;
	}
	case 2:
	{
		if (--frames_until_done == GAME_OVER_END_X)
		{
			state++;
		}
		break;
	}
	case 3:
	{
		frames_until_done = TIME_OVER_PAUSE_X;
		state++;
		break;
	}
	case 4:
	{
		if (--frames_until_done == GAME_OVER_END_X)
		{
			room_goto(rmCharacterSelect);
		}
		break;
	}
}