/// @description Update
if (ctrlGame.game_paused) exit;

if (control_lock_time > 0 and on_ground) control_lock_time--;
if (recovery_time > 0) recovery_time--;

if (invincibility_time > 0) 
{
	invincibility_time--;
}

if (superspeed_time != 0)
{
    superspeed_time -= sign(superspeed_time);
    if (superspeed_time == 0) player_refresh_physics();
}

animation_update();
with (spin_dash_dust) animation_update();
with (shield) animation_update();