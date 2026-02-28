/// @description Update

with (character_portrait) 
{
	x = other.char_portrait_x;
	index = clamp_inverse(index, 0, other.cursor_cap + other.amy_unlocked);
	index = other.cursor;
	animation_update();
}
with (up_arrow) animation_update();
with (down_arrow) animation_update();