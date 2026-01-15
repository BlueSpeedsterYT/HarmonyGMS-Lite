/// @description Initialize
image_speed = 0;

stream = -1;
overlay = -1;
queue = ds_priority_create();

/// @method play_music(soundid)
/// @description Plays the given music track, muting it if an overlay is playing, and sets it as the current stream.
/// @param {Asset.GMSound} soundid Sound asset to play.
play_music = function (soundid, priority = PRIORITY_MUSIC, loop = true)
{
	audio_stop_sound(stream);
	var music_volume = (global.volume_music * global.volume_master);
	stream = audio_play_sound(soundid, priority, loop, music_volume * (overlay == -1));
};