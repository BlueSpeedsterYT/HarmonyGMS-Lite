/// @description Start stage

// Set stage data and music
switch (room)
{
	case rmTest:
	{
		name = "DEMONSTRATION";
		act = 1;
		music_enqueue(bgmBlazeEventScrewStache, PRIORITY_MUSIC, true);
		break;
	}
}

transition_to(-1);