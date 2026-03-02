/// @description Behave

// Skip intro
if (timer > time_to_frames(0, 3) && (InputPressed(INPUT_VERB.CONFIRM) | InputPressed(INPUT_VERB.CANCEL)))
{
	timer = time_to_frames(0, 3);
}

// Launch the player!
if (--timer == 0)
{
	stage_init();
	with (objPlayer)
	{
		x_speed = other.speed_boost ? 9 : 4;
	}
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

// Set liftoff animation
if (timer >= time_to_frames(0, (1 + 1. / 6.)) and timer < time_to_frames(0, 3))
{
	with (objPlayer)
	{
		if (not animation_is_matching(PLAYER_ANIMATION.BEFORE_COUNTDOWN, 1))
		{
			animation_play(PLAYER_ANIMATION.BEFORE_COUNTDOWN, 1);
		}
	}
}

with (machine)
{
	animation_play(-1);
	switch (animation_data.index)
	{
		case -1:
		{
			animation_set(global.ani_level_machine_start_v0);
			if (not objPlayer.input_allow)
			{
				x = objPlayer.x div 1;
				y = objPlayer.y div 1;
			}
			break;
		}
	}
}

if (not instance_in_view())
{
	instance_destroy();
}