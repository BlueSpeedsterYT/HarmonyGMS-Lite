/// @description Update
event_inherited();
if (ctrlGame.game_paused & PAUSE_FLAG.MENU) exit;
with (trick_fx) animation_update();
with (insta_shield) animation_update();