/// @description Initialize
// Inherit the parent event
event_inherited();

direction = darccos(image_xscale);
ani_spring = global.ani_spring_horizontal;

hitbox_update = function()
{
	switch (animation_data.variant)
	{
		case 0:
		{
			hitboxes[0].set_size(0, -5, 20, 5);
			break;
		}
		case 1:
		{
			switch (image_index)
			{
				case 0:
				{
					hitboxes[0].set_size(0, -5, 20, 5);
					break;
				}
				case 1:
				{
					hitboxes[0].set_size(0, -5, 18, 5);
					break;
				}
				case 2:
				{
					hitboxes[0].set_size(0, -5, 33, 5);
					break;
				}
				case 3:
				{
					hitboxes[0].set_size(0, -5, 29, 5);
					break;
				}
				case 4:
				{
					hitboxes[0].set_size(0, -5, 32, 5);
					break;
				}
			}
			break;
		}
	}
}