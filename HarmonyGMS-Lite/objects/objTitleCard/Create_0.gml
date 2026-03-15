/// @description Initialize
image_speed = 0;
character_icon_frame = [0, 0, 1, 2, 0];
triangle_frame = [0, 0, 1, 2, 0];
triangle_pos_x = CAMERA_WIDTH;
triangle_pos_y = CAMERA_HEIGHT;
getting_ready_duration = [40, 55, 52, 40, 40];
act_letters_frames = [0, 1, 2, (ctrlZone.act == 1) ? 3 : 4];
act_letters_pos_x = [CAMERA_WIDTH - 108, CAMERA_WIDTH - 87, CAMERA_WIDTH - 66, CAMERA_WIDTH - 44];
act_letters_pos_y = [CAMERA_HEIGHT - 63, CAMERA_HEIGHT - 59, CAMERA_HEIGHT - 55, CAMERA_HEIGHT - 51];
act_letters_offset_y = [10, -8, 6, -4, 2, 0];
act_letters_drawn_x = array_create(4, 0);
act_letters_drawn_y = array_create(4, -32);
counter = 0;
skipped_intro = false;
ctrlGame.game_flags |= GAME_FLAG.HIDE_HUD;