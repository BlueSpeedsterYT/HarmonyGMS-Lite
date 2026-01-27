/// @description Draw

	// Black Fade
	// TODO: That.
	
	// Game/Time Text
	var left_sprite = (game_over_cause & GAME_OVER_TYPE.ZERO_LIVES) ? sprHUDGame : sprHUDTime; 
	draw_sprite(left_sprite, 0, left_x, CAMERA_HEIGHT_CENTER);
	
	// Over Text
	draw_sprite(sprHUDOver, 0, right_x, CAMERA_HEIGHT_CENTER);
	
	// Reset Drawing
	draw_reset();