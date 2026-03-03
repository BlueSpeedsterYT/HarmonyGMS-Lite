/// @description Start stage

// Set stage data
switch (room)
{
	case rmTest:
	{
		name = "DEMONSTRATION";
		act = 1;
		music_enqueue(musBlazeEventScrewStache, PRIORITY_MUSIC, true);
		stage_init();
		stage_pause_allow(true);
		instance_create_layer(0, 0, "Overlays", objHUD);
		break;
	}
	case rmTest2:
	{
		name = "LEAF FOREST";
		act = 1;
		music_enqueue(musHydrocityAct1Sonic360, PRIORITY_MUSIC, true);
		instance_create_layer(0, 0, "Overlays", objTitleCard);
		break;
	}
}

