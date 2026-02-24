// Constants
#macro CAMERA_ID view_camera[0]
#macro CAMERA_PADDING 64
#macro CAMERA_WIDTH 284
#macro CAMERA_HEIGHT 160
#macro CAMERA_WIDTH_CENTER (CAMERA_WIDTH / 2)
#macro CAMERA_HEIGHT_CENTER (CAMERA_HEIGHT / 2)
#macro CAMERA_X_BORDER 0
#macro CAMERA_Y_BORDER 32
#macro CAMERA_X_OFFSET (CAMERA_X_BORDER / 2)
#macro CAMERA_Y_OFFSET (CAMERA_Y_BORDER / 2)
#macro CAMERA_PAN_TARGET_UP -(CAMERA_HEIGHT_CENTER - (CAMERA_Y_OFFSET - 8))
#macro CAMERA_PAN_TARGET_DOWN (CAMERA_HEIGHT_CENTER - (CAMERA_Y_OFFSET + 8))

#macro PRIORITY_SOUND 0 
#macro PRIORITY_MUSIC 1
#macro PRIORITY_OVERLAY 2

#macro DEPTH_OFFSET_AFTERIMAGE 25
#macro DEPTH_OFFSET_PLAYER 50
#macro DEPTH_OFFSET_PARTICLE 75

#macro COLL_FLAG_TOP 0x10000
#macro COLL_FLAG_BOTTOM 0x20000
#macro COLL_FLAG_LEFT 0x40000
#macro COLL_FLAG_RIGHT 0x80000

#macro GAME_MODE_IS_TIME_ATTACK (ctrlGame.game_mode == GAME_MODE.TIME_ATTACK)
#macro DEBUG_ENABLED (ctrlGame.game_debug == true)
#macro LIVES_ENABLED (db_read(DATABASE_CONFIG, CONFIG_DEFAULT_LIVES, "lives") and (not GAME_MODE_IS_TIME_ATTACK))
#macro TIME_OVER_ENABLED (db_read(DATABASE_CONFIG, CONFIG_DEFAULT_TIME_OVER, "time_over"))

#macro TEN_MILLISECONDS 1000
#macro PLAYER_HEIGHT 14

#macro SCORE_CAP 999999
#macro RING_CAP 999
#macro LIVES_CAP 255

enum GAME_FLAG
{
	NONE = (1 << 0),
	KEEP_CHARACTERS = (1 << 1),
	KEEP_SCORE = (1 << 2),
	HIDE_PAUSE_MENU = (1 << 3),
	HIDE_HUD = (1 << 4),
}

enum PAUSE_FLAG
{
	NONE = (1 << 0),
	MENU = (1 << 1),
	TEXT = (1 << 2),
	TRANSITION = (1 << 3),
}

enum GAME_OVER_TYPE
{
	NONE = (1 << 0),
	ZERO_LIVES = (1 << 1),
	TIME_UP = (1 << 2)
}

enum GAME_MODE
{
	SINGLE, TIME_ATTACK,
}

enum CAMERA_STATE
{
	NULL = -1, FOLLOW, RETURN, KNUCKLES
}

enum ITEM_INDEX
{
	ONE_UP, SHIELD, SHIELD_MAGNETIC, INVINCIBILITY, SPEED_UP, RINGS_RANDOM, RINGS_5, RINGS_10
}

// Volumes
global.volume_master = 1;
global.volume_sound = 1;
global.volume_music = 1;

// Stage
global.character = CHARACTER.NONE;
global.score_count = 0;
global.ring_count = 0;
global.life_count = 3;

// Fonts
global.font_system = font_add_sprite(sprFontSystem, ord(" "), true, 1);
global.font_debug = font_add_sprite(sprFontDebug, ord("!"), false, 1);
global.font_hud = font_add_sprite(sprFontHUD, ord("!"), false, 0);

// Misc.
surface_depth_disable(true);
randomize();

// Start the game!
call_later(1, time_source_units_frames, room_goto_next);

/* AUTHOR NOTE: `room_goto_next` executes at the end of the function/event it was called in,
meaning calling it here would result in the global controllers not being created.
Thus, it is instead called 1 frame later.

Note, however, this means the initialization room will be shown for that 1 frame.
Calling `room_goto_next` in the room's Creation Code does not address this, either. */