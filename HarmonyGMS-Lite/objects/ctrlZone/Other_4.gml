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
	case rmTest2:
	{
		name = "LEAF FOREST";
		act = 1;
		music_enqueue(bgmHydrocityAct1Sonic360, PRIORITY_MUSIC, true);
		break;
	}
}

transition_to(-1);