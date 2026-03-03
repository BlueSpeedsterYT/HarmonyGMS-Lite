/// @description Behave
if (ctrlGame.game_paused & PAUSE_FLAG.MENU) exit;

// Skip intro
if (timer > time_to_frames(0, 3) && (InputPressed(INPUT_VERB.CONFIRM) | InputPressed(INPUT_VERB.CANCEL)))
{
	timer = time_to_frames(0, 3);
}

// Play Announcer Countdown
if (timer == time_to_frames(0, 3))
{
	sound_play(voAnnouncer3);
}
else if (timer == time_to_frames(0, 2))
{
	sound_play(voAnnouncer2);
}
else if (timer == time_to_frames(0, 1))
{
	sound_play(voAnnouncer1);
}

// Launch the player!
if (--timer == 0)
{
	stage_init();
	with (objPlayer)
	{
		player_perform(player_is_running);
		x_speed = other.speed_boost ? 9 : 4;
	}
	instance_destroy();
	race_start_message_create();
	sound_play(voAnnouncerGo);
}
// Give the player a speed boost
else if (timer < 5)
{
	if (InputPressed(INPUT_VERB.RIGHT) and disable_boost == false)
	{
		speed_boost = true;
	}
}
// Disable boost if early
else
{
	if (InputPressed(INPUT_VERB.RIGHT))
	{
		disable_boost = true;
	}
}

with (countdown)
{
	var countdown_time = other.timer;
	if (countdown_time < time_to_frames(0, 3))
	{
		visible = true;
		x = CAMERA_WIDTH_CENTER;
		y = CAMERA_HEIGHT_CENTER - 24;
		image_index = 2 - (countdown_time div 60);
	}
}

// Set liftoff animation
// NOTE: The hardcoded magic number of `71` is needed as it matches the duration length of
// the second variant for the pre-countdown animation.
// Just... don't pause during the whole thing will you?
if (timer >= 71 and timer < time_to_frames(0, 3))
{
	with (objPlayer)
	{
		animation_play(PLAYER_ANIMATION.BEFORE_COUNTDOWN, 1);
	}
}