/// @description Fade in music
overlay = -1;
var music_volume = (global.volume_music * global.volume_master);
audio_sound_gain(stream, music_volume, 1000);