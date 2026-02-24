/// @description Behave

	switch (state)
	{
		case 0:
		{
			if (++anim_frames > 23)
			{
				anim_frames = 0;
				state++;
			}
			break;
		}
		case 1:
		{
			if ((++anim_frames > 60) or InputPressed(INPUT_VERB.CONFIRM))
			{
				InputVerbConsumeAll();
				cursor_anim_frame++;
				anim_frames = 0;
				state++;
				render_transition_ui_in();
			}
			else
			{
				
			}
			break;
		}
		case 2:
		{
			cursor_anim_frame++;
			if (++anim_frames >= 16)
			{
				cursor_anim_frame++;
				anim_frames = 0;
				state++;
			}
			else
			{
				render_transition_ui_in();
			}
			break;
		}
		case 3:
		{
			var input_axis_x = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
			var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
			previous_cursor = clamp_inverse(previous_cursor, 0, cursor_cap + amy_unlocked);
			cursor = clamp_inverse(cursor, 0, cursor_cap + amy_unlocked);
	
			if (complete_selection)
			{
				if (unlocked_characters[cursor] == true)
				{
					animation_play(cursor, 1);
					global.character = cursor;
					anim_frames = 0;
					state = 7;
				}
			}
			else
			{
				if (input_axis_x != 0 or input_axis_y != 0)
				{
					if (input_axis_x == 1 or input_axis_y == 1)
					{
						cursor_anim_frame = 0;
						arrow_active_frames[0] = 12;
						previous_cursor = cursor;
						cursor++;
						anim_frames = 0;
						sound_play(sfxCSSCursor);
					}
					else if (input_axis_x == -1 or input_axis_y == -1)
					{
						cursor_anim_frame = 0;
						arrow_active_frames[1] = 12;
						previous_cursor = cursor;
						cursor--;
						anim_frames = 0;
						sound_play(sfxCSSCursor);
					}
			
					animation_play(cursor, 0);
				}
				else
				{
					if (InputPressed(INPUT_VERB.CONFIRM) and unlocked_characters[cursor] == true)
					{
						animation_play(cursor, 1);
						global.character = cursor;
						anim_frames = 0;
						state = 7;
					}
				}
			}
			break;
		}
		case 4:
		{
			break;
		}
		case 5:
		{
			break;
		}
		case 6:
		{
			break;
		}
		case 7:
		{
			InputVerbConsumeAll();
			anim_frames++;
			if (anim_frames >= 30)
			{
				audio_stop_all();
				music_clear();
				room_goto(rmTest2);
			}
			break;
		}
	}