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
			if (game_over_cause & GAME_OVER_TYPE.ZERO_LIVES)
			{
				// TODO: Play jingle here
			}
			else
			{
				// TODO: Play sound here.
			}
			state++;
		}
		break;
	}
	case 1:
	{
		if (game_over_cause & GAME_OVER_TYPE.ZERO_LIVES)
		{
			if (frames_until_done > 60)
			{
				var temp_x = frames_until_done + (CAMERA_WIDTH_CENTER - 20);
				left_x = temp_x;
				right_x = temp_x;
			}
			else
			{
				left_x = CAMERA_WIDTH_CENTER;
				right_x = CAMERA_WIDTH_CENTER;
			}
			
			if (--frames_until_done == 0)
			{
				frames_until_done = 120;
				state++;
			}
		}
		else
		{
			if (--frames_until_done == 0)
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
			}
			
			update_over_text(game_over_cause);
		}
		break;
	}
	case 2:
	{
		if (--frames_until_done == 0)
		{
			state++;
		}
		break;
	}
	case 3:
	{
		frames_until_done = 140;
		state++;
		break;
	}
	case 4:
	{
		if (--frames_until_done == 0)
		{
			game_restart();
		}
		break;
	}
}