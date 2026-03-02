/// @description Behave

counter++;

// Skip the intro animation
if (InputPressed(INPUT_VERB.CONFIRM))
{
	counter = 200;
	skipped_intro = true;
}

if (counter == (200 - getting_ready_duration[global.character]))
{
	with (objPlayer)
	{
		if (not animation_is_matching(PLAYER_ANIMATION.BEFORE_COUNTDOWN, 0))
		{
			animation_play(PLAYER_ANIMATION.BEFORE_COUNTDOWN, 0);
		}
	}
}

if (counter > 200)
{
	countdown_create(skipped_intro);
	instance_destroy();
}
