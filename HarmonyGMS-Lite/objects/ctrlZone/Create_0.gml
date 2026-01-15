/// @description Initialize
image_speed = 0;
stage_players = [];

// Timing
stage_time = 0;
time_limit = time_to_frames(10, 0);
time_over = false;
time_enabled = true;

// Stage data
name = "";
act = 0;

// Setup tilemaps; discard invalid ones
tilemaps =
[
	layer_tilemap_get_id("CollisionMain"),
	layer_tilemap_get_id("CollisionPlane0"),
	layer_tilemap_get_id("CollisionPlane1"),
	layer_tilemap_get_id("CollisionSemisolid")
];

if (tilemaps[3] == -1) array_pop(tilemaps);
if (tilemaps[1] == -1) array_delete(tilemaps, 1, 2);