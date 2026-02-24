/// @description Draw
var x_int = x div 1;
var y_int = y div 1;

if (index == ITEM_INDEX.ONE_UP)
{
	draw_sprite(sprItemIcon, global.character, x_int, y_int + icon_offset);
}
else
{
	draw_sprite(sprItemIcon, index + (CHARACTER.MAX - 1), x_int, y_int + icon_offset);
}

if (show_itembox)
{
	draw_self_as(sprItemBox, 0);
}