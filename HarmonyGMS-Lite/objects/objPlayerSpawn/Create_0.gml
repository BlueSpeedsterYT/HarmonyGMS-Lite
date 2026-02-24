/// @description Initialize
if (global.character == CHARACTER.NONE)
{
	instance_destroy();
}
else
{
	var player_objects = [objSonic, noone, objTails, objKnuckles, noone];
	var player_inst = instance_create_depth(x - 32, y, depth - DEPTH_OFFSET_PLAYER, player_objects[global.character]);
	with (player_inst) player_index = 0;
	with (ctrlZone) stage_player = player_inst;
	instance_create_depth(x, y, depth - DEPTH_OFFSET_PLAYER, objCamera);
	instance_destroy();
}