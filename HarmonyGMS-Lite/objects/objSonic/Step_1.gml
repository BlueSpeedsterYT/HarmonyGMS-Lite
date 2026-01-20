/// @description Update
if (ctrlGame.game_paused) exit;

// Inherit the parent event
event_inherited();

with (trick_spin) animation_update();
with (insta_shield) animation_update();