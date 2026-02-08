/// @description Setup
// Inherit the parent event
event_inherited();

direction = darcsin(image_yscale);
ani_spring = global.ani_spring_bouncy;

hitbox_update = function()
{
	switch (animation_data.variant)
	{
		case 0:
		{
			hitboxes[0].set_size(-5, -21, 5, 0);
			break;
		}
		case 1:
		{
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(-5, -21, 5, 0);
					break;
				}
				case 1:
				{
					hitboxes[0].set_size(-5, -18, 5, 0);
					break;
				}
				case 2:
				{
					hitboxes[0].set_size(-5, -25, 5, 0);
					break;
				}
			}
			break;
		}
		case 2:
		{
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(-5, -21, 5, 0);
					break;
				}
				case 1:
				{
					hitboxes[0].set_size(-5, -18, 5, 0);
					break;
				}
				case 3:
				{
					hitboxes[0].set_size(-5, -28, 5, 0);
					break;
				}
				case 4:
				{
					hitboxes[0].set_size(-5, -26, 5, 0);
					break;
				}
			}
			break;
		}
		case 3:
		{
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(-5, -21, 5, 0);
					break;
				}
				case 1:
				{
					hitboxes[0].set_size(-5, -18, 5, 0);
					break;
				}
				case 3:
				{
					hitboxes[0].set_size(-5, -28, 5, 0);
					break;
				}
				case 5:
				{
					hitboxes[0].set_size(-5, -45, 5, 0);
					break;
				}
			}
			break;
		}
	}
}