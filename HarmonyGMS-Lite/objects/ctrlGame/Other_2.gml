/// @description Setup

// Constants
#macro CAMERA_ID view_camera[0]
#macro CAMERA_PADDING 64
#macro CAMERA_WIDTH 396
#macro CAMERA_HEIGHT 224
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

#macro DEBUG_ENABLED (ctrlGame.game_debug == true)
#macro LIVES_ENABLED (ctrlGame.game_mode == GAME_MODE.SINGLE)

#macro LOOK_DURATION time_to_frames(0, 2)
#macro SLIDE_DURATION 32
#macro RECOVERY_DURATION time_to_frames(0, 2)
#macro INVINCIBILITY_DURATION time_to_frames(0, 20)
#macro SUPERSPEED_DURATION time_to_frames(0, 20)
#macro TAILS_FLIGHT_DURATION time_to_frames(0, 8)
#macro SPRING_DURATION 16
#macro TRICK_LOCK_DURATION 9

// All Characters
#macro CEILING_LAND_THRESHOLD -4
#macro SLIDE_THRESHOLD 2.5
#macro ROLL_THRESHOLD 1.03125
#macro UNROLL_THRESHOLD 0.5
#macro BRAKE_THRESHOLD 4
#macro AIR_DRAG_THRESHOLD 0.125
#macro AIR_DRAG 0.96875
#macro SLOPE_FRICTION 0.125
#macro ROLL_SLOPE_FRICTION_UP 0.078125
#macro ROLL_SLOPE_FRICTION_DOWN 0.3125
#macro SPIN_DASH_ATROPHY 0.96875

#macro PLAYER_HEIGHT 14

// Sonic
#macro SONIC_BOUND_FORCE 0.21875
#macro SONIC_BOUND_HEIGHT 6

// Tails
#macro TAILS_FLY_BASE_FORCE 0.03125
#macro TAILS_FLY_ASCEND_FORCE 0.125
#macro TAILS_FLY_THRESHOLD -1

// Knuckles
#macro KNUCKLES_GLIDE_ACCELERATION 0.015625
#macro KNUCKLES_GLIDE_SLIDE_FRICTION 0.125
#macro KNUCKLES_CLIMB_SPEED 1

#macro SCORE_CAP 999999999
#macro RING_CAP 999
#macro LIVES_CAP 999 

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
	TEXT = (1 << 1),
	TRANSITION = (1 << 2),
	MENU = (1 << 3),
}

enum GAME_MODE
{
	SINGLE, MULTI, TIME_ATTACK
}

enum CHARACTER
{
	NONE = -1, SONIC, TAILS, KNUCKLES
}

enum SHIELD
{
	NONE, BASIC, MAGNETIC
}

enum PHASE
{
	ENTER, STEP, EXIT
}

enum PLAYER_ANIMATION
{
	// Shared Animations
	IDLE, TEETER, TURN, RUN, BRAKE, LOOK, CROUCH,
	ROLL, SPIN_DASH, FALL, JUMP,
	HURT, DEAD, 
	TRICK_UP, TRICK_DOWN, TRICK_FRONT, TRICK_BACK, 
	SPRING, SPRING_TWIRL, DASH,
	// Sonic-Only Animations
	INSTA_SHIELD, FORWARD_THRUST, SKIDDING,
	// Tails-Only Animations
	TAIL_SWIPE, FLYING, FLYING_TURN, FLYING_TIRED,
	// Knuckles-Only Animations
	GLIDE, GLIDE_TURN, GLIDE_SLIDING, GLIDE_FALL,
	CLIMB_ATTACH, CLIMB, // <-- This includes the idle, movement, lifting upwards and landing animations
	SPIRAL_ATTACK
}

enum TRICK_TYPE
{
	UP, DOWN, FRONT, BACK
}


enum CAMERA_STATE
{
	NULL = -1, FOLLOW, RETURN, KNUCKLES
}

// Volumes
global.volume_master = 1;
global.volume_sound = 1;
global.volume_music = 1;

// Music
set_loop_points(bgmBlazeEventScrewStache, (1419264 div 44100), (10019092 div 44100));

// Player values
global.characters = [];
global.score_count = 0;
global.ring_count = 0;
global.life_count = 3;

// Fonts
global.font_debug = font_add_sprite(sprFontDebug, ord("!"), false, 1);

// Misc.
surface_depth_disable(true);
InputPartySetParams(INPUT_VERB.CONFIRM, 1, INPUT_MAX_PLAYERS, false, INPUT_VERB.CANCEL, undefined);
randomize();

// Create global controllers
instance_create_layer(0, 0, "Controllers", ctrlWindow);
instance_create_layer(0, 0, "Controllers", ctrlMusic);

// Start game
transition_to(rmTest2);