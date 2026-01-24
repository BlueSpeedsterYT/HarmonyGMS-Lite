/// @description Setup

game_over_cause = GAME_OVER_TYPE.NONE;
delay = 0;
state = 0;
frames_until_done = 0;
left_x = 0;
right_x = CAMERA_WIDTH;

/// @method update_over_text(screen_type)
update_over_text = function(screen_type)
{
	if (frames_until_done > 140)
	{
		var temp_x = (CAMERA_WIDTH_CENTER + 140) - frames_until_done;
		left_x = temp_x;
		right_x = temp_x;
	}
	else if (frames_until_done > 40)
	{
		left_x = CAMERA_WIDTH_CENTER;
		right_x = CAMERA_WIDTH_CENTER;
	}
	else if (frames_until_done > 0)
	{
		var final_temp_x = CAMERA_WIDTH_CENTER - ((40 - frames_until_done) * 2);
		left_x = final_temp_x;
		right_x = final_temp_x;
	}
}