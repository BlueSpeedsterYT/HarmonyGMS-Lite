/// @description Initialize
event_inherited();
hitboxes[0].set_size(-2, -11, 4, 12);
reaction = function (pla)
{
	// Be free
	if (collision_player(0, pla))
	{
		// collide
		show_debug_message("i really hate dimps");
	}
};