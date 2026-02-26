/// @description Initialize
if (global.character == CHARACTER.NONE)
{
	instance_destroy();
}
else
{
	var player_objects = [objSonic, noone, objTails, objKnuckles, noone];
	if (player_objects[global.character] == noone)
	{
		instance_destroy();
	}
	else
	{
		var player_inst = instance_create_depth(x - 32, y, depth, player_objects[global.character]);
		with (player_inst) player_index = 0;
		with (ctrlZone) stage_player = player_inst;
		instance_create_layer(x, y, layer, objCamera);
		instance_destroy();
	}
}