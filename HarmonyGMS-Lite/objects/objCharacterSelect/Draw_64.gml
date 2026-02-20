/// @description Render
draw_sprite(sprCSSBackground, 0, CAMERA_WIDTH_CENTER, CAMERA_HEIGHT_CENTER);

if (sprite_exists(sprite_index))
{
	draw_sprite(sprite_index, image_index, char_portrait_x, CAMERA_HEIGHT_CENTER - 52);
}

draw_set_font(global.font_system);
draw_set_align(fa_left, fa_top);
draw_text(8, 8, "IN-DEV");
draw_reset();