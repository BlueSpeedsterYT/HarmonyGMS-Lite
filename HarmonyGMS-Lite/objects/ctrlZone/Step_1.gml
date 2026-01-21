/// @description Time
if (ctrlGame.game_paused) exit;

if (time_enabled and ++stage_time == time_limit)
{
	time_over = true;
	time_enabled = false;
	if (TIME_OVER_ENABLED)
	{
		with (objPlayer) player_damage(id);
	}
}