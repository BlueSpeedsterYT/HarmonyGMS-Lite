/// @description Initialize
image_speed = 0;
audio_pause_all();
sound_play(sfxMenuPause);
cursor = 0;
with (ctrlGame) game_paused |= PAUSE_FLAG.MENU;

/// @method menu_close([destroy])
/// @description Closes the pause menu.
/// @param {Bool} [destroy] Destroy the menu (optional, defaults to true).
menu_close = function(destroy = true)
{
    ctrlGame.game_paused &= ~PAUSE_FLAG.MENU;
    InputVerbConsumeAll();
    if (destroy) instance_destroy();
};