/// @description Setup
// Inherit the parent event
event_inherited();

direction = darctan2(image_yscale, image_xscale);
ani_spring = global.ani_spring_diagonal;

hitbox_update = function()
{
	switch (animation_data.variant)
	{
		case 0:
		{
			hitboxes[0].set_size(10, -18, 20, -8);
			break;
		}
		case 1:
		{
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(10, -18, 20, -8);
					break;
				}
				case 1:
				{
					hitboxes[0].set_size(6, -15, 16, -5);
					break;
				}
				case 2:
				{
					hitboxes[0].set_size(17, -26, 27, -16);
					break;
				}
				case 3:
				{
					hitboxes[0].set_size(13, -22, 23, -12);
					break;
				}
				case 4:
				{
					hitboxes[0].set_size(16, -25, 26, -15);
					break;
				}
			}
			break;
		}
	}
}