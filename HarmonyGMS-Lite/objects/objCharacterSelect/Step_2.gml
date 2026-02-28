/// @description Animate

with (character_portrait)
{
	switch (index)
	{
		default:
		case CHARACTER.SONIC:
		{
			animation_set(global.ani_css_sonic_portrait);
			break;
		}
		case CHARACTER.TAILS:
		{
			animation_set(global.ani_css_tails_portrait);
			break;
		}
		case CHARACTER.KNUCKLES:
		{
			animation_set(global.ani_css_knuckles_portrait);
			break;
		}
	}
}

with (up_arrow)
{
	if (animation_data.index == 0)
	{
		animation_set(global.ani_css_arrow);
	}
}

with (down_arrow)
{
	if (animation_data.index == 0)
	{
		image_yscale = -1;
		animation_set(global.ani_css_arrow);
	}
}