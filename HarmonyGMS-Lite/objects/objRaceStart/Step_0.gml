/// @description Behave
if (ctrlGame.game_paused & PAUSE_FLAG.MENU) exit;

timer--;

if (timer == 0)
{
	instance_destroy();
	return;
}

var display_timer = timer;
with (start_message)
{
	x = CAMERA_WIDTH_CENTER;
	y = CAMERA_HEIGHT_CENTER / 2;
	
	if (display_timer < 16)
	{
		image_xscale = (512 - display_timer * 16) / 256;
		image_yscale = ((display_timer + 1) * 16) / 256;
	}
	else
	{
		image_xscale = 1;
		image_yscale = 1;
	}
}