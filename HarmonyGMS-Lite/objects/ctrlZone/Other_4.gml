/// @description Start stage

// Set stage data and music
switch (room)
{
	case rmTest:
	{
		name = "DEMONSTRATION";
		act = 1;
		music_enqueue(musBlazeEventScrewStache, PRIORITY_MUSIC, true);
		break;
	}
	case rmTest2:
	{
		name = "LEAF FOREST";
		act = 1;
		music_enqueue(musHydrocityAct1Sonic360, PRIORITY_MUSIC, true);
		break;
	}
}

// Create UI elements
instance_create_layer(0, 0, "Overlays", objHUD);

