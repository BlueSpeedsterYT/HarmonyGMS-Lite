/// @description Initialize
// Inherit the parent event
event_inherited();

ani_spring = global.ani_spring_diagonal_alt;

hitbox_update = function()
{
	switch (animation_data.variant)
	{
		case 0:
		{
			hitboxes[0].set_size(10, -10, 20, 0);
			break;
		}
		case 1:
		{
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(10, -10, 20, 0);
					break;
				}
				case 1:
				{
					hitboxes[0].set_size(6, -7, 16, 0);
					break;
				}
				case 2:
				{
					hitboxes[0].set_size(17, -18, 27, -8);
					break;
				}
				case 3:
				{
					hitboxes[0].set_size(13, -14, 23, -4);
					break;
				}
				case 4:
				{
					hitboxes[0].set_size(16, -17, 26, -7);
					break;
				}
			}
			break;
		}
	}
}