/// @description Fade out and in
image_alpha = clamp(image_alpha, 0, 1);

if (target_room != -1)
{
	image_alpha += image_speed;
	if (image_alpha >= 1)
	{
		room_goto(target_room);
		target_room = -1;
		image_alpha = 1;
	}
}
else
{
	image_alpha -= image_speed;
	if (image_alpha <= 0) instance_destroy();
}