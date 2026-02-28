/// @description Initialize
image_speed = 0;
music_enqueue(musCharacterSelect, PRIORITY_MUSIC, true);
state = 0;
amy_unlocked = false;
unlocked_characters = [true, false, true, true, amy_unlocked];
cursor = 0;
previous_cursor = 0;
cursor_cap = 3;
unknown_timer = 16; //it is basically unknown in SA2's decomp code but it does act as a anim_frames replacement.
cursor_anim_frame = 0;
up_arrow_active_frames = 0;
down_arrow_active_frames = 0;
anim_frames = 0;
char_title_x = CAMERA_WIDTH + (CAMERA_WIDTH - 20);
char_portrait_base_x = CAMERA_WIDTH - 74;
char_name_yscale = 0;
char_sub_name_base_x = CAMERA_WIDTH - 74;
char_portrait_x = CAMERA_WIDTH + char_portrait_base_x;
char_sub_name_x = CAMERA_WIDTH + char_sub_name_base_x;
complete_selection = false;
exiting = false;
scrolled_down = false;
up_arrow = new stamp();
up_arrow.x = CAMERA_WIDTH_CENTER - 103;
up_arrow.y = CAMERA_HEIGHT_CENTER - 62;
down_arrow = new stamp();
down_arrow.x = CAMERA_WIDTH_CENTER - 103;
down_arrow.y = CAMERA_HEIGHT_CENTER + 62;
character_portrait = new stamp();
with (character_portrait)
{
	x = other.char_portrait_x;
	y = CAMERA_HEIGHT_CENTER + 50;
	index = other.cursor;
}

/// @method character_selected(reason)
/// @param {Boolean|Array} reason A reason to accept the selection
character_selected = function(reason)
{
	if (reason == true)
	{
		with (character_portrait) animation_play(index, 1);
		global.character = cursor;
		anim_frames = 0;
		state = 7;
	}
}

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
		i = ((ceil(CAMERA_HEIGHT / 10) - anim_frames) * 20);
	}
	char_title_x = i + CAMERA_WIDTH;
	
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
		// TODO: Make this sliding portrait work for the love of god.
		//char_portrait_x = char_portrait_base_x + ((CAMERA_WIDTH_CENTER + 8) - (dcos(i * 90) / 128)) * 2;
		char_portrait_x = char_portrait_base_x;
	}
	else
	{
		char_portrait_x = char_portrait_base_x;
	}
	
	with (character_portrait)
	{
		animation_play(index, 0);
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
	char_sub_name_x = char_sub_name_base_x + (i * 20);
	
	char_name_yscale = 256 - ((16 - anim_frames) * 15);
}

/// @method render_carousel_scroll()
render_carousel_scroll = function()
{
	var character_portait_i = 0, character_title_i = 0, character_subname_i = 0;
	
	if (unknown_timer >= 8)
	{
		character_portait_i = 0;
		character_title_i = 8;
	}
	else
	{
		character_portait_i = 8 - unknown_timer;
		character_title_i = unknown_timer;
	}
	
	if (unknown_timer < 4)
	{
		character_subname_i = 8;
	}
	else if (unknown_timer < 12)
	{
		character_subname_i = (12 - unknown_timer);
	}
	else
	{
		character_subname_i = 0;
	}
	
	if (unknown_timer == 0)
	{
		with (character_portrait) 
		{
			animation_play(index, 0);
		}
	}
	
	if (character_portait_i > 0)
	{
		// TODO: Make this sliding portrait work for the love of god.
		//char_portrait_x = char_portrait_base_x + ((CAMERA_WIDTH_CENTER + 8) - (dcos(character_portait_i * 90) / 128)) * 2;
		char_portrait_x = char_portrait_base_x;
	}
	else
	{
		char_portrait_x = char_portrait_base_x;
	}
	
	char_sub_name_x = char_sub_name_base_x + (character_subname_i * 20);
	
	char_title_x = CAMERA_WIDTH;
	
	if (character_title_i < 8)
	{
		char_name_yscale = 256 - ((8 - character_title_i) * 30);
	}
	else
	{
		char_name_yscale = 256;
	}
}