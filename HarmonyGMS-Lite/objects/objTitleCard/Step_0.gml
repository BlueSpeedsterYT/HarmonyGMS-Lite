/// @description Behave
if (ctrlGame.game_paused & PAUSE_FLAG.MENU) exit;

var frame_counter = counter;
frame_counter++;

// Skip the intro animation
if (InputPressed(INPUT_VERB.CONFIRM))
{
	counter = 200;
	skipped_intro = true;
}

counter = frame_counter;

if (frame_counter == (200 - getting_ready_duration[global.character]))
{
	with (objPlayer)
	{
		animation_play(PLAYER_ANIMATION.BEFORE_COUNTDOWN, 0);
	}
}

if (frame_counter > 200)
{
	ctrlGame.game_flags &= ~GAME_FLAG.HIDE_HUD;
	stage_pause_allow(true);
	instance_create_layer(0, 0, "Overlays", objHUD);
	countdown_create(skipped_intro);
	instance_destroy();
}
