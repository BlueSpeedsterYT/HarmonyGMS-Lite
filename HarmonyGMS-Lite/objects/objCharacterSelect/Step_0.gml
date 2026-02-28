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
				render_carousel_scroll();
				state++;
				return;
			}
			
			render_transition_ui_in();
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
				character_selected(true);
			}
			else
			{
				if (input_axis_x != 0 or input_axis_y != 0)
				{
					if (input_axis_x == -1 or input_axis_y == -1)
					{
						up_arrow_active_frames = 12;
						previous_cursor = cursor;
						cursor--;
						scrolled_down = false;
						with (up_arrow) animation_play(0, 1);
						state = 4;
					}
					else if (input_axis_x == 1 or input_axis_y == 1)
					{
						down_arrow_active_frames = 12;
						previous_cursor = cursor;
						cursor++;
						scrolled_down = true;
						with (down_arrow) animation_play(0, 1);
						state = 5;
					}
					
					cursor_anim_frame = 0;
					anim_frames = 0;
					unknown_timer = 0;
					sound_play(sfxCSSCursor);
					render_carousel_scroll();
				}
				else
				{
					if (InputPressed(INPUT_VERB.CONFIRM))
					{
						character_selected(unlocked_characters[cursor]);
					}
					else
					{
						render_carousel_scroll();
					}
				}
			}
			break;
		}
		case 4:
		{
			unknown_timer++;
			
			if (up_arrow_active_frames != 0)
			{
				up_arrow_active_frames--;
				if (up_arrow_active_frames == 0)
				{
					with (up_arrow) animation_play(0, 0);
				}
			}
			
			if (InputPressed(INPUT_VERB.CONFIRM) and unlocked_characters[cursor] == true)
			{
				complete_selection = true;
			}
			//else if(InputPressed(INPUT_VERB.CANCEL))
			//{
			//	if (not exiting)
			//	{
			//		sound_play(sfxMenuBack);
			//	}
				
			//	exiting = true;
			//}
			
			if (++anim_frames > 9)
			{
				anim_frames = 0;
				state = 6;
			}
			
			render_carousel_scroll();
			break;
		}
		case 5:
		{
			unknown_timer++;
			
			if (down_arrow_active_frames != 0)
			{
				down_arrow_active_frames--;
				if (down_arrow_active_frames == 0)
				{
					with (down_arrow) animation_play(0, 0);
				}
			}
			
			if (InputPressed(INPUT_VERB.CONFIRM) and unlocked_characters[cursor] == true)
			{
				complete_selection = true;
			}
			//else if(InputPressed(INPUT_VERB.CANCEL))
			//{
			//	if (not exiting)
			//	{
			//		sound_play(sfxMenuBack);
			//	}
				
			//	exiting = true;
			//}
			
			if (++anim_frames > 9)
			{
				anim_frames = 0;
				state = 6;
			}
			
			render_carousel_scroll();
			break;
		}
		case 6:
		{
			unknown_timer++;
			
			if (up_arrow_active_frames != 0)
			{
				up_arrow_active_frames--;
				if (up_arrow_active_frames == 0)
				{
					with (up_arrow) animation_play(0, 0);
				}
			}
			
			if (down_arrow_active_frames != 0)
			{
				down_arrow_active_frames--;
				if (down_arrow_active_frames == 0)
				{
					with (down_arrow) animation_play(0, 0);
				}
			}
			
			if (InputPressed(INPUT_VERB.CONFIRM) and unlocked_characters[cursor] == true)
			{
				complete_selection = true;
			}
			
			if (++anim_frames > 5)
			{
				cursor_anim_frame++;
				state = 3;
			}
			
			render_carousel_scroll();
			break;
		}
		case 7:
		{
			InputVerbConsumeAll();
			anim_frames++;
			cursor_anim_frame = (cursor_anim_frame & 0x3F) + 1;
			
			if (up_arrow_active_frames != 0)
			{
				up_arrow_active_frames--;
				if (up_arrow_active_frames == 0)
				{
					with (up_arrow) animation_play(0, 0);
				}
			}
			
			if (down_arrow_active_frames != 0)
			{
				down_arrow_active_frames--;
				if (down_arrow_active_frames == 0)
				{
					with (down_arrow) animation_play(0, 0);
				}
			}
			
			if (anim_frames >= 30)
			{
				audio_stop_all();
				music_clear();
				room_goto(rmTest2);
			}
			break;
		}
	}