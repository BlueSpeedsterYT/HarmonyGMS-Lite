/// @description Plays the given sound effect, stopping any existing instances of it beforehand.
/// @param {Asset.GMSound} soundid Sound asset to play.
/// @returns {Id.Sound}
function sound_play(soundid)
{
	audio_stop_sound(soundid);
	var sound_vol = (global.volume_sound * global.volume_master);
	return audio_play_sound(soundid, PRIORITY_SOUND, false, sound_vol);
}

/// @description Sets the loop points of the given music track.
/// @param {Asset.GMSound} soundid Sound asset to set loop points for.
/// @param {Real} [loop_start] Start point of the loop in seconds.
/// @param {Real} [loop_end] End point of the loop in seconds.
function set_loop_points(soundid, loop_start = 0, loop_end = 0)
{
    audio_sound_loop_start(soundid, loop_start);
	audio_sound_loop_end(soundid, loop_end);
}

/// @description Plays the given music track as an overlay, muting the stream until it has finished playing.
/// @param {Asset.GMSound} soundid Sound asset to play.
function music_overlay(soundid)
{
	with (ctrlMusic)
	{
		// Stop existing overlay, otherwise mute stream
		if (overlay != -1) audio_stop_sound(overlay);
		else audio_sound_gain(stream, 0);
		
		// Play overlay
		var music_volume = (global.volume_music * global.volume_master);
		overlay = audio_play_sound(soundid, PRIORITY_OVERLAY, false, music_volume);
		alarm[0] = audio_sound_length(soundid) * room_speed;
	}
}

/// @description Adds the given music track to the queue, playing it if it has the highest priority.
/// @param {Asset.GMSound} soundid Sound asset to add.
/// @param {Real} priority Priority value to set.
/// @param {Bool} loop Looping value to set.
function music_enqueue(soundid, priority, loop)
{
	with (ctrlMusic)
	{
		if (ds_priority_find_priority(queue, soundid) == undefined)
		{
			ds_priority_add(queue, soundid, priority);
		}
		
		if (ds_priority_find_max(queue) == soundid)
		{
			play_music(soundid, priority, loop);
		}
	}
}

/// @description Removes the given music track from the queue. If it was streaming, the track below it is then played.
/// @param {Asset.GMSound} soundid Sound asset to remove.
function music_dequeue(soundid)
{
	with (ctrlMusic)
	{
		ds_priority_delete_value(queue, soundid);
		if (audio_is_playing(soundid)) play_music(ds_priority_find_max(queue));
	}
}