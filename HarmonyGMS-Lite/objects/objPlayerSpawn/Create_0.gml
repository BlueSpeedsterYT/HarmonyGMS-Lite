/// @description Setup
if (not (ctrlGame.game_flags & GAME_FLAG.KEEP_CHARACTERS))
{
	global.characters = [];
	for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
	{
		var character_id = [CHARACTER.KNUCKLES, CHARACTER.NONE];
		if (character_id[i] != CHARACTER.NONE) array_push(global.characters, character_id[i]);
	}
}

var player_objects = [objSonic, objTails, objKnuckles];
with (ctrlZone) stage_players = [];
for (var i = 0; i < array_length(global.characters); i++)
{
    var character_index = global.characters[i];
    var player_inst = instance_create_depth(x - i * 32, y, depth + i - DEPTH_OFFSET_PLAYER, player_objects[character_index]);
    with (player_inst) player_index = i;
	with (ctrlZone) array_push(stage_players, player_inst);
}
instance_create_depth(x, y, depth - DEPTH_OFFSET_PLAYER, objCamera);
instance_destroy();