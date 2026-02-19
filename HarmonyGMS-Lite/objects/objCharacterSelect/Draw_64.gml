/// @description Render
//draw_sprite(sprGuideCSS, cursor, CAMERA_WIDTH, 0);

if (sprite_exists(sprite_index))
{
	draw_sprite(sprite_index, image_index, CAMERA_WIDTH - 74, CAMERA_HEIGHT_CENTER + 50);
}

draw_set_font(global.font_system);
draw_set_align(fa_left, fa_top);
draw_text(8, 8, "IN-DEV");
draw_reset();