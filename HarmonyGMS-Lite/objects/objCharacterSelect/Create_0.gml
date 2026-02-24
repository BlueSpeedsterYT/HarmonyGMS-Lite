/// @description Initialize
image_speed = 0;
music_enqueue(musCharacterSelect, PRIORITY_MUSIC, true);
state = 0;
amy_unlocked = false;
unlocked_characters = [true, false, true, true, amy_unlocked];
cursor = 0;
previous_cursor = 0;
cursor_cap = 3;
cursor_anim_frame = 0;
complete_selection = false;
anim_frames = 0;
arrow_active_frames = [0, 0];
char_title_x = CAMERA_WIDTH + (CAMERA_WIDTH_CENTER - 20);
char_portrait_base_x = CAMERA_WIDTH_CENTER + 46;
char_name_yscale = 0;
char_sub_name_base_x = CAMERA_WIDTH_CENTER + 46;
char_portrait_x = CAMERA_WIDTH + char_portrait_base_x;
char_sub_name_x = CAMERA_WIDTH + char_sub_name_base_x;
animation_data = new animation_core();
animation_play(cursor, 0);

/// @method render_transition_ui_in()
render_transition_ui_in = function()
{
	var i;
	if (anim_frames < 8)
	{
		i = CAMERA_HEIGHT;
	}
	else
	{
		i = ((16 - anim_frames) * 20);
	}
	char_title_x = i + (CAMERA_WIDTH_CENTER - 20);
	
	if (anim_frames < 8)
	{
		i = 8 - anim_frames;
	}
	else
	{
		i = 0;
	}
	
	if (i > 0)
	{
		char_portrait_x = char_portrait_base_x + ((128 - (dcos(i * 16) / 128)) * 2);
	}
	else
	{
		char_portrait_x = char_portrait_base_x;
	}
	
	if (anim_frames < 4)
	{
		i = 8;
	}
	else if (anim_frames < 12)
	{
		i = (12 - anim_frames);
	}
	else
	{
		i = 0;
	}
	char_sub_name_x = char_sub_name_base_x + i * 20;
	
	char_name_yscale = 256 - ((16 - anim_frames) * 15);
}