/// @description Behave
if (ctrlGame.game_paused) exit;

if (not show_itembox)
{
	if (not icon_static)
	{
		if (frames++ >= 60)
		{
			frames = 0;
			icon_static = true;
			itembox_apply_item(player_index);
		}
		else
		{
			icon_offset -= 1;
		}
	}
	else
	{
		if (frames++ >= 30)
		{
			instance_destroy();
		}
	}
}