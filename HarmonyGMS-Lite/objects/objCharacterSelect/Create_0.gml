/// @description Initialize
image_speed = 0;
music_enqueue(musCharacterSelect, PRIORITY_MUSIC, true);
cursor = 0;
intro = true;
skip_intro_timer = 0;
rotation_speed = 0;
allow_input = false;
fade_delay = 0;
char_portrait_active = false;
char_portrait_land = false;
char_portrait_x = CAMERA_WIDTH;
char_portrait_base_x = CAMERA_WIDTH_CENTER - 13;
char_portrait_x_speed = 0;
char_portrait_x_grav = 0;
animation_data = new animation_core();
animation_play(cursor, 0);