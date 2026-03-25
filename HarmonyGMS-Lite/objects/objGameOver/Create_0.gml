/// @description Initialize

game_over_cause = GAME_OVER_TYPE.NONE;
delay = 0;
state = 0;
frames_until_done = 0;
left_x = 0;
right_x = CAMERA_WIDTH;

/// @method update_time_over_text()
update_time_over_text = function()
{
	if (frames_until_done > TIME_OVER_PAUSE_X)
	{
		var temp_x = (frames_until_done * 2) - (TIME_OVER_PAUSE_X + 20);
		left_x = temp_x;
		right_x = temp_x;
	}
	else if (frames_until_done > TIME_OVER_RESUME_X)
	{
		left_x = CAMERA_WIDTH_CENTER;
		right_x = CAMERA_WIDTH_CENTER;
	}
	else if (frames_until_done > TIME_OVER_END_X)
	{
		var final_temp_x = CAMERA_WIDTH_CENTER - ((TIME_OVER_RESUME_X - frames_until_done) * 2);
		left_x = final_temp_x;
		right_x = final_temp_x;
	}
	else
	{
		return;
	}
}