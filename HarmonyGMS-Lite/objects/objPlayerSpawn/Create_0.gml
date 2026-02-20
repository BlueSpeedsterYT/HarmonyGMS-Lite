/// @description Initialize
if (not (ctrlGame.game_flags & GAME_FLAG.KEEP_CHARACTERS))
{
	global.characters = [];
	for (var i = 0; i < INPUT_MAX_PLAYERS; i++)
	{
		var character_index = db_read(DATABASE_SAVE, CHARACTER.NONE, "character", i);
		if (character_index != CHARACTER.NONE) array_push(global.characters, character_index);
	}
}

var player_objects = [objSonic, objTails, objKnuckles];
with (ctrlZone) stage_players = [];
for (var i = 0; i < array_length(global.characters); i++)
{
    var character_index = global.characters[i];
    var player_inst = instance_create_depth(x - i * 32, y, depth + i - DEPTH_OFFSET_PLAYER, player_objects[character_index]);
    with (player_inst) player_index = i;
	stage_player_add(player_inst);
}
with (ctrlGame) game_flags &= ~GAME_FLAG.KEEP_CHARACTERS;
instance_create_depth(x, y, depth - DEPTH_OFFSET_PLAYER, objCamera);
instance_destroy();