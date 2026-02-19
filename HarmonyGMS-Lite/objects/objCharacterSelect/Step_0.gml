/// @description Behave

	if (animation_data.variant == 1 and animation_is_finished())
	{
		db_write(DATABASE_SAVE, cursor, "character", 0);
		db_write(DATABASE_SAVE, CHARACTER.NONE, "character", 1);
		audio_stop_all();
		music_clear();
		room_goto(rmTest2);
	}
	
	if (animation_data.variant == 1) exit;
	
	var input_axis_x = InputOpposingRepeat(INPUT_VERB.LEFT, INPUT_VERB.RIGHT);
	var input_axis_y = InputOpposingRepeat(INPUT_VERB.UP, INPUT_VERB.DOWN);
	cursor = clamp_inverse(cursor, 0, CHARACTER.MAX - 1);
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
	else if (InputPressed(INPUT_VERB.CONFIRM))
	{
		animation_play(cursor, 1);
	}