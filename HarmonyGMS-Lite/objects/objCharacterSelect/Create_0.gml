/// @description Initialize
image_speed = 0;
music_enqueue(musCharacterSelect, PRIORITY_MUSIC, true);
cursor = 0;
animation_data = new animation_core();
animation_play(cursor, 0);