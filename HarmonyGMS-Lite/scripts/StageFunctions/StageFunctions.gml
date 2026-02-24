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