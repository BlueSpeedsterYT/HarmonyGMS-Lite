/// @description Sets up the needed Game Over screen
/// @param {Real} type Type of Game Over gotten.
function game_over_create(type)
{
	if (instance_exists(objGameOver)) exit;
	
	with (instance_create_depth(0, 0, ctrlZone.overlays_depth, objGameOver))
	{
		game_over_cause = type;
		delay = 10;
		frames_until_done = (type == GAME_OVER_TYPE.ZERO_LIVES) ? GAME_OVER_START_X : TIME_OVER_START_X;
	}
}

/// @description Sets up the countdown
/// @param {Real} has_skipped Skip the countdown timer just a slight bit.
function countdown_create(has_skipped)
{
	if (instance_exists(objCountdown)) exit;
	
	with (instance_create_depth(objPlayer.x div 1, objPlayer.y div 1, ctrlZone.overlays_depth, objCountdown))
	{
		speed_boost = false;
		disable_boost = false;
		if (not has_skipped)
		{
			timer = time_to_frames(0, 5) + 10;
		}
		else
		{
			timer = time_to_frames(0, 3);
		}
	}
}

/// @description Sets up the race start message
function race_start_message_create()
{
	if (instance_exists(objRaceStart)) exit;
	
	with (instance_create_depth(objPlayer.x div 1, objPlayer.y div 1, ctrlZone.overlays_depth, objRaceStart))
	{
		timer = time_to_frames(0, 1);
	}
}