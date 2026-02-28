/// @description Render
cursor = clamp_inverse(cursor, 0, cursor_cap + amy_unlocked);
//draw_sprite(sprCSSGuide, cursor, CAMERA_WIDTH_CENTER, CAMERA_HEIGHT_CENTER);

draw_sprite(sprCSSBackground, 0, CAMERA_WIDTH_CENTER, CAMERA_HEIGHT_CENTER);

var char_name_frame = (unlocked_characters[cursor] == true) ? cursor : CHARACTER.MAX;
draw_sprite(sprCSSCharacterSubName, char_name_frame, char_sub_name_x, CAMERA_HEIGHT - 16);
draw_sprite_ext(sprCSSCharacterName, char_name_frame, CAMERA_WIDTH_CENTER - 80, CAMERA_HEIGHT_CENTER, 1, (char_name_yscale / 256), 0, c_white, 1);

draw_sprite(sprCSSTitle, 0, char_title_x, 16);

with (up_arrow) draw_self_floored();
with (down_arrow) draw_self_floored();

with (character_portrait)
{
	index = clamp_inverse(index, 0, other.cursor_cap + other.amy_unlocked);
	draw_self_floored();
}

draw_set_font(global.font_system);
draw_set_align(fa_left, fa_top);
draw_text(8, 8, "IN-DEV");
draw_reset();