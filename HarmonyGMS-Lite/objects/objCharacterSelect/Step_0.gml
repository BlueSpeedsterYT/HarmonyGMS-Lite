/// @description Behave

	if (intro)
	{
		//if (skip_intro_timer++ >= 60 and InputPressed(INPUT_VERB.CONFIRM))
		if (skip_intro_timer++ >= 60)
		{
			cursor = 0;
			intro = false;
			allow_input = true;
		}
	}
	
	var input_axis_x = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
	var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
	cursor = clamp_inverse(cursor, 0, CHARACTER.MAX - 1);
	char_portrait_x -= char_portrait_x_grav;
	char_portrait_x_grav += char_portrait_x_speed;
	if (char_portrait_x_grav < 0)
	{
		char_portrait_x_grav = 0;
		char_portrait_x_speed = 0;
	}
	if (char_portrait_active)
	{
		if (char_portrait_x < (char_portrait_base_x + 64))
		{
			char_portrait_x_speed -= 1.3;
		}
		if (char_portrait_x <= char_portrait_base_x)
		{
			char_portrait_x = char_portrait_base_x;
		}
		if (char_portrait_x == char_portrait_base_x)
		{
			char_portrait_land = true;
		}
		if (char_portrait_x != char_portrait_base_x)
		{
			char_portrait_land = false;
		}
	}
	
	if (allow_input)
	{
		if (input_axis_x != 0 or input_axis_y != 0)
		{
			if (input_axis_x == 1 or input_axis_y == 1)
			{
				cursor++;
			}
			else if (input_axis_x == -1 or input_axis_y == -1)
			{
				cursor--;
			}
			animation_play(cursor, 0);
		}
		else if (InputPressed(INPUT_VERB.CONFIRM) and char_portrait_land == true)
		{
			allow_input = false;
			animation_play(cursor, 1);
		}
	}
	
	if (allow_input and ((not char_portrait_active) or (input_axis_x != 0 or input_axis_y != 0)))
	{
		char_portrait_x_grav = 17;
		char_portrait_active = true;
	}
	
	if ((not char_portrait_active and char_portrait_base_x > 0) or
	(allow_input and (input_axis_x != 0 or input_axis_y != 0)))
	{
		char_portrait_x = CAMERA_WIDTH;
		char_portrait_x_speed = 0;
	}
	
	if (animation_data.variant == 1 and animation_is_finished())
	{
		if (fade_delay++ >= 20)
		{
			db_write(DATABASE_SAVE, cursor, "character", 0);
			db_write(DATABASE_SAVE, CHARACTER.NONE, "character", 1);
			audio_stop_all();
			music_clear();
			room_goto(rmTest2);
		}
	}