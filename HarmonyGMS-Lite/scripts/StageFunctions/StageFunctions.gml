function stage_init()
{
	with(objPlayer) input_allow = true;
	stage_time_allow(true);
}

function stage_pause_allow(allow)
{
	with (ctrlZone) pause_enabled = allow;
}

function stage_time_get()
{
	with (ctrlZone) return stage_time;
}

function stage_time_set(set)
{
	with (ctrlZone) stage_time = set;
}

function stage_time_allow(allow)
{
	with (ctrlZone) time_enabled = allow;
}

#region Player

function stage_player_get(player_id)
{
	with (ctrlZone)
	{
		var player_inst = array_get(stage_players, player_id);
		if (player_inst != noone) return player_inst;
	}
	return noone;
}

function stage_player_add(player_inst)
{
	with (ctrlZone) array_push(stage_players, player_inst);
}

function stage_player_find()
{
	with (ctrlZone) return array_get_index(stage_players, other.id);
}

function stage_player_delete(player_id)
{
	with (ctrlZone) return array_delete(stage_players, player_id, 1);
}

#endregion