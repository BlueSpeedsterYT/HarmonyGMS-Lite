/// @description Setup
global.characters = [CHARACTER.TAILS, CHARACTER.NONE];

var player_objects = [objSonic, objTails, objKnuckles];
ctrlZone.stage_players = array_create(INPUT_MAX_PLAYERS, noone);
for (var i = 0; i < array_length(global.characters); i++)
{
    var character_index = global.characters[i];
    if (character_index == CHARACTER.NONE) break;
    var player_inst = instance_create_depth(x - i * 32, y, depth + i - DEPTH_OFFSET_PLAYER, player_objects[character_index]);
    with (player_inst) player_index = i;
	ctrlZone.stage_players[i] = player_inst;
}
instance_create_depth(x, y, depth - DEPTH_OFFSET_PLAYER, objCamera);
instance_destroy();