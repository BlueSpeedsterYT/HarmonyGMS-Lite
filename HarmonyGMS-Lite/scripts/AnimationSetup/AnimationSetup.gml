#region Explosions

global.ani_explosion_destroy_v0 = new animation(sprExplosionDestroy, [3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 6], -1);

#endregion

#region Objects

global.ani_ring_sparkle_v0 = new animation(sprRingSparkle, 4, -1);

global.ani_spring_vertical_v0 = new animation(sprSpringVertical, 0);
global.ani_spring_vertical_v1 = new animation(sprSpringVertical, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_vertical = [global.ani_spring_vertical_v0, global.ani_spring_vertical_v1];

global.ani_spring_horizontal_v0 = new animation(sprSpringHorizontal, 0);
global.ani_spring_horizontal_v1 = new animation(sprSpringHorizontal, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_horizontal = [global.ani_spring_horizontal_v0, global.ani_spring_horizontal_v1];

global.ani_spring_diagonal_v0 = new animation(sprSpringDiagonal, 0);
global.ani_spring_diagonal_v1 = new animation(sprSpringDiagonal, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_diagonal = [global.ani_spring_diagonal_v0, global.ani_spring_diagonal_v1];

global.ani_spring_diagonal_alt_v0 = new animation(sprSpringDiagonalAlt, 0);
global.ani_spring_diagonal_alt_v1 = new animation(sprSpringDiagonalAlt, [2, 4, 2, 4, 2], -1, [1, 2, 3, 4, 5]);
global.ani_spring_diagonal_alt = [global.ani_spring_diagonal_alt_v0, global.ani_spring_diagonal_alt_v1];

#endregion

#region Player

global.ani_brake_dust_v0 = new animation(sprBrakeDust, 2, -1);

global.ani_spin_dash_dust_v0 = new animation(sprSpinDashDust0, 2);
global.ani_spin_dash_dust_v1 = new animation(sprSpinDashDust1, 2);
global.ani_spin_dash_dust = [global.ani_spin_dash_dust_v0, global.ani_spin_dash_dust_v1];

global.ani_shield_basic_v0 = new animation(sprShieldBasic, 3);

global.ani_shield_magnetic_v0 = new animation(sprShieldMagnetic, 3);

global.ani_shield_invincibility_v0 = new animation(sprShieldInvincibility, 2);
global.ani_shield_invincibility_sparkle_v0 = new animation(sprShieldInvincibilitySparkle, 2, -1);

#endregion

#region Sonic

global.ani_sonic_idle_v0 = new animation(sprSonicIdle, [6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 12, 6, 6, 6, 12, 8, 6, 6, 6, 6]);

global.ani_sonic_teeter_front_v0 = new animation(sprSonicTeeterFront, 3, 1);
global.ani_sonic_teeter_back_v0 = new animation(sprSonicTeeterBack, [3, 4, 4, 4, 4, 4, 4, 4, 4], 1);
global.ani_sonic_teeter = [global.ani_sonic_teeter_front_v0, global.ani_sonic_teeter_back_v0];

global.ani_sonic_turn_v0 = new animation(sprSonicTurn, 1, -1);
global.ani_sonic_turn_brake_v0 = new animation(sprSonicTurnBrake, 2, -1);
global.ani_sonic_turn = [global.ani_sonic_turn_v0, global.ani_sonic_turn_brake_v0];

global.ani_sonic_run_v0 = new animation(sprSonicRun0, 8);
global.ani_sonic_run_v1 = new animation(sprSonicRun1, 8);
global.ani_sonic_run_v2 = new animation(sprSonicRun2, 8);
global.ani_sonic_run_v3 = new animation(sprSonicRun3, 8);
global.ani_sonic_run_v4 = new animation(sprSonicRun4, 8);
global.ani_sonic_run = [global.ani_sonic_run_v0, global.ani_sonic_run_v1, global.ani_sonic_run_v2, global.ani_sonic_run_v3, global.ani_sonic_run_v4];

global.ani_sonic_brake_v0 = new animation(sprSonicBrake, [2, 4, 4], 1);
global.ani_sonic_brake_fast_v0 = new animation(sprSonicBrakeFast, [1, 1, 3, 3], 2);
global.ani_sonic_brake = [global.ani_sonic_brake_v0, global.ani_sonic_brake_fast_v0];

global.ani_sonic_look_v0 = new animation(sprSonicLook, [4, 4, 12, 12, 12, 12], 2);
global.ani_sonic_look_v1 = new animation(sprSonicLook, 2, -1, [1, 0]);
global.ani_sonic_look = [global.ani_sonic_look_v0, global.ani_sonic_look_v1];

global.ani_sonic_crouch_v0 = new animation(sprSonicCrouch, 1, -1);
global.ani_sonic_crouch_v1 = new animation(sprSonicCrouch, 1, -1, [1, 0]);
global.ani_sonic_crouch = [global.ani_sonic_crouch_v0, global.ani_sonic_crouch_v1];

global.ani_sonic_roll_v0 = new animation(sprSonicRoll, 2);

global.ani_sonic_spin_dash_v0 = new animation(sprSonicSpinDash0, 2);
global.ani_sonic_spin_dash_v1 = new animation(sprSonicSpinDash1, 2, -1);
global.ani_sonic_spin_dash = [global.ani_sonic_spin_dash_v0, global.ani_sonic_spin_dash_v1];

global.ani_sonic_fall_v0 = new animation(sprSonicSpring1, 2, -1, [4, 5]);
global.ani_sonic_fall_v1 = new animation(sprSonicSpring2, 2);
global.ani_sonic_fall = [global.ani_sonic_fall_v0, global.ani_sonic_fall_v1];

global.ani_sonic_jump_v0 = new animation(sprSonicJump0, [3, 2], -1);
global.ani_sonic_jump_v1 = new animation(sprSonicJump1, 2);
global.ani_sonic_jump_v2 = new animation(sprSonicJump2, [1, 2, 2, 2], 1);
global.ani_sonic_jump = [global.ani_sonic_jump_v0, global.ani_sonic_jump_v1, global.ani_sonic_jump_v2];

global.ani_sonic_hurt_v0 = new animation(sprSonicHurt0, [3, 8, 8, 8, 8], -1);
global.ani_sonic_hurt_v1 = new animation(sprSonicHurt1, 5, -1);
global.ani_sonic_hurt = [global.ani_sonic_hurt_v0, global.ani_sonic_hurt_v1];

global.ani_sonic_dead_v0 = new animation(sprSonicDead, [3, 3, 12, 2, 3, 3], 4);

global.ani_sonic_trick_up_v0 = new animation(sprSonicTrickUp0, [3, 6, 2], -1);
global.ani_sonic_trick_up_v1 = new animation(sprSonicTrickUp1, [1, 1, 3, 3, 3], 2);
global.ani_sonic_trick_up_v2 = new animation(sprSonicTrickUp2, [3, 3, 3, 2, 2, 2], 3);
global.ani_sonic_trick_up = [global.ani_sonic_trick_up_v0, global.ani_sonic_trick_up_v1, global.ani_sonic_trick_up_v2];

global.ani_sonic_trick_down_v0 = new animation(sprSonicTrickDown0, [3, 3, 6, 2, 2, 2, 2, 2], -1);
global.ani_sonic_trick_down_v1 = new animation(sprSonicTrickDown1, [2, 2, 2, 2, 3, 3, 3], 4);
global.ani_sonic_trick_down_v2 = new animation(sprSonicTrickDown2, 1, -1);
global.ani_sonic_trick_down = [global.ani_sonic_trick_down_v0, global.ani_sonic_roll_v0, global.ani_sonic_trick_down_v1];

global.ani_sonic_trick_front_v0 = new animation(sprSonicTrickFront0, [2, 4, 1], -1);
global.ani_sonic_trick_front_v1 = new animation(sprSonicTrickFront1, 1);
global.ani_sonic_trick_front = [global.ani_sonic_trick_front_v0, global.ani_sonic_trick_front_v1];

global.ani_sonic_trick_back_v0 = new animation(sprSonicTrickBack, 1, -1, [0]);
global.ani_sonic_trick_back_v1 = new animation(sprSonicTrickBack, [5, 4, 3, 2, 2, 2, 2, 2, 3, 3, 3], 8);
global.ani_sonic_trick_back = [global.ani_sonic_trick_back_v0, global.ani_sonic_trick_back_v1];

global.ani_sonic_spring_v0 = new animation(sprSonicSpring0, 3, 1);
global.ani_sonic_spring_v1 = new animation(sprSonicSpring1, [2, 2, 2, 3, 3, 3], -1);
global.ani_sonic_spring_v2 = new animation(sprSonicSpring2, 3);
global.ani_sonic_spring = [global.ani_sonic_spring_v0, global.ani_sonic_spring_v1, global.ani_sonic_spring_v2];

global.ani_sonic_spring_twirl_v0 = new animation(sprSonicSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Tails

global.ani_tails_idle_v0 = new animation(sprTailsIdle, 8);

global.ani_tails_teeter_front_v0 = new animation(sprTailsTeeterFront, 3, 1);
global.ani_tails_teeter_back_v0 = new animation(sprTailsTeeterBack, 4, 1);
global.ani_tails_teeter = [global.ani_tails_teeter_front_v0, global.ani_tails_teeter_back_v0];

global.ani_tails_turn_v0 = new animation(sprTailsTurn, 1, -1);
global.ani_tails_turn_brake_v0 = new animation(sprTailsTurnBrake, 2, -1);
global.ani_tails_turn = [global.ani_tails_turn_v0, global.ani_tails_turn_brake_v0];

global.ani_tails_run_v0 = new animation(sprTailsRun0, 8);
global.ani_tails_run_v1 = new animation(sprTailsRun1, 8);
global.ani_tails_run_v2 = new animation(sprTailsRun2, 8);
global.ani_tails_run_v3 = new animation(sprTailsRun3, 8);
global.ani_tails_run_v4 = new animation(sprTailsRun4, 8);
global.ani_tails_run_v5 = new animation(sprTailsRun5, 8);
global.ani_tails_run = [global.ani_tails_run_v0, global.ani_tails_run_v1, global.ani_tails_run_v2, global.ani_tails_run_v3, global.ani_tails_run_v4, global.ani_tails_run_v5];

global.ani_tails_brake_v0 = new animation(sprTailsBrake, [2, 4, 4, 4], 1);
global.ani_tails_brake_fast_v0 = new animation(sprTailsBrakeFast, [2, 3, 3], 1);
global.ani_tails_brake = [global.ani_tails_brake_v0, global.ani_tails_brake_fast_v0];

global.ani_tails_look_v0 = new animation(sprTailsLook, [4, 4, 10, 10, 10, 10], 2);
global.ani_tails_look_v1 = new animation(sprTailsLook, 2, -1, [1, 0]);
global.ani_tails_look = [global.ani_tails_look_v0, global.ani_tails_look_v1];

global.ani_tails_crouch_v0 = new animation(sprTailsCrouch, [1, 1, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6], 2);
global.ani_tails_crouch_v1 = new animation(sprTailsCrouch, 1, -1, [1, 0]);
global.ani_tails_crouch = [global.ani_tails_crouch_v0, global.ani_tails_crouch_v1];

global.ani_tails_roll_v0 = new animation(sprTailsRoll, 2);
global.ani_tails_tails_v0 = new animation(sprTailsTails, 2);

global.ani_tails_spin_dash_v0 = new animation(sprTailsSpinDash0, 2);
global.ani_tails_spin_dash_v1 = new animation(sprTailsSpinDash1, 2, -1);
global.ani_tails_spin_dash = [global.ani_tails_spin_dash_v0, global.ani_tails_spin_dash_v1];

global.ani_tails_fall_v0 = new animation(sprTailsSpring1, 2, -1, [4, 5]);
global.ani_tails_fall_v1 = new animation(sprTailsSpring2, 2);
global.ani_tails_fall = [global.ani_tails_fall_v0, global.ani_tails_fall_v1];

global.ani_tails_jump_v0 = new animation(sprTailsJump0, 3, -1);
global.ani_tails_jump_v1 = new animation(sprTailsJump1, 2);
global.ani_tails_jump_v2 = new animation(sprTailsJump2, [1, 2, 2, 2, 2, 2]);
global.ani_tails_jump = [global.ani_tails_jump_v0, global.ani_tails_jump_v1, global.ani_tails_jump_v2];

global.ani_tails_hurt_v0 = new animation(sprTailsHurt0, [3, 8, 8, 8, 8], -1);
global.ani_tails_hurt_v1 = new animation(sprTailsHurt1, 5, -1);
global.ani_tails_hurt = [global.ani_tails_hurt_v0, global.ani_tails_hurt_v1];

global.ani_tails_dead_v0 = new animation(sprTailsDead, [3, 3, 12, 2, 3, 3], 4);

global.ani_tails_trick_up_v0 = new animation(sprTailsTrickUp0, [2, 1, 1, 8], -1);
global.ani_tails_trick_up_v1 = new animation(sprTailsTrickUp1, [3, 4, 4, 4, 4], 2);
global.ani_tails_trick_up_v2 = new animation(sprTailsTrickUp2, [2, 4, 4, 3, 3, 3], 3);
global.ani_tails_trick_up = [global.ani_tails_trick_up_v0, global.ani_tails_trick_up_v1, global.ani_tails_trick_up_v2];

global.ani_tails_trick_down_v0 = new animation(sprTailsTrickDown0, [2, 2, 4], -1);
global.ani_tails_trick_down_v1 = new animation(sprTailsTrickDown1, [2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3], 3);
global.ani_tails_trick_down = [global.ani_tails_trick_down_v0, global.ani_tails_trick_down_v1];

global.ani_tails_trick_front_v0 = new animation(sprTailsTrickFront0, [2, 2, 2, 2, 4], -1);
global.ani_tails_trick_front_v1 = new animation(sprTailsTrickFront1, [2, 1, 1, 1, 3, 3, 3, 3, 3, 3, 3, 3], 4);
global.ani_tails_trick_front_v2 = new animation(sprTailsTrickFront2, 3, 1);
global.ani_tails_trick_front = [global.ani_tails_trick_front_v0, global.ani_tails_trick_front_v1, global.ani_tails_trick_front_v2];

global.ani_tails_trick_back_v0 = new animation(sprTailsTrickBack0, [2, 2, 2, 4], -1);
global.ani_tails_trick_back_v1 = new animation(sprTailsTrickBack1, [2, 2, 2, 3, 3, 3, 3], 3);
global.ani_tails_trick_back_v2 = new animation(sprTailsTrickBack2, [4, 4, 4, 4, 3, 3, 3, 3, 3, 3], 7);
global.ani_tails_trick_back = [global.ani_tails_trick_back_v0, global.ani_tails_trick_back_v1, global.ani_tails_trick_back_v2];

global.ani_tails_spring_v0 = new animation(sprTailsSpring0, 2);
global.ani_tails_spring_v1 = new animation(sprTailsSpring1, [2, 3, 3, 4, 4, 4], -1);
global.ani_tails_spring_v2 = new animation(sprTailsSpring2, 3, 1);
global.ani_tails_spring = [global.ani_tails_spring_v0, global.ani_tails_spring_v1, global.ani_tails_spring_v2];

global.ani_tails_spring_twirl_v0 = new animation(sprTailsSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

#endregion

#region Knuckles

global.ani_knuckles_idle_v0 = new animation(sprKnucklesIdle, [5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 10, 5, 5, 5, 5, 5, 5, 5, 12, 6, 5, 5, 5, 5, 5, 5]);

global.ani_knuckles_teeter_front_v0 = new animation(sprKnucklesTeeterFront, 3, 1);
global.ani_knuckles_teeter_back_v0 = new animation(sprKnucklesTeeterBack, [3, 4, 4, 4, 4, 4, 4], 1);
global.ani_knuckles_teeter = [global.ani_knuckles_teeter_front_v0, global.ani_knuckles_teeter_back_v0];

global.ani_knuckles_turn_v0 = new animation(sprKnucklesTurn, 1, -1);
global.ani_knuckles_turn_brake_v0 = new animation(sprKnucklesTurnBrake, 1, -1);
global.ani_knuckles_turn = [global.ani_knuckles_turn_v0, global.ani_knuckles_turn_brake_v0];

global.ani_knuckles_run_v0 = new animation(sprKnucklesRun0, 8);
global.ani_knuckles_run_v1 = new animation(sprKnucklesRun1, 8);
global.ani_knuckles_run_v2 = new animation(sprKnucklesRun2, 8);
global.ani_knuckles_run_v3 = new animation(sprKnucklesRun3, 8);
global.ani_knuckles_run_v4 = new animation(sprKnucklesRun4, 8);
global.ani_knuckles_run = [global.ani_knuckles_run_v0, global.ani_knuckles_run_v1, global.ani_knuckles_run_v2, global.ani_knuckles_run_v3, global.ani_knuckles_run_v4];

global.ani_knuckles_brake_v0 = new animation(sprKnucklesBrake, 2, 1);
global.ani_knuckles_brake_fast_v0 = new animation(sprKnucklesBrakeFast, [1, 1, 3, 3], 2);
global.ani_knuckles_brake = [global.ani_knuckles_brake_v0, global.ani_knuckles_brake_fast_v0];

global.ani_knuckles_look_v0 = new animation(sprKnucklesLook, [4, 4, 2], -1);
global.ani_knuckles_look_v1 = new animation(sprKnucklesLook, 2, -1, [1, 0]);
global.ani_knuckles_look = [global.ani_knuckles_look_v0, global.ani_knuckles_look_v1];

global.ani_knuckles_crouch_v0 = new animation(sprKnucklesCrouch, 1, -1);
global.ani_knuckles_crouch_v1 = new animation(sprKnucklesCrouch, 1, -1, [1, 0]);
global.ani_knuckles_crouch = [global.ani_knuckles_crouch_v0, global.ani_knuckles_crouch_v1];

global.ani_knuckles_roll_v0 = new animation(sprKnucklesRoll, 2);

global.ani_knuckles_spin_dash_v0 = new animation(sprKnucklesSpinDash0, 2);
global.ani_knuckles_spin_dash_v1 = new animation(sprKnucklesSpinDash1, 2, -1);
global.ani_knuckles_spin_dash = [global.ani_knuckles_spin_dash_v0, global.ani_knuckles_spin_dash_v1];

global.ani_knuckles_fall_v0 = new animation(sprKnucklesSpring1, 2, -1, [4, 5]);
global.ani_knuckles_fall_v1 = new animation(sprKnucklesSpring2, 2);
global.ani_knuckles_fall = [global.ani_knuckles_fall_v0, global.ani_knuckles_fall_v1];

global.ani_knuckles_jump_v0 = new animation(sprKnucklesJump0, [3, 2], -1);
global.ani_knuckles_jump_v1 = new animation(sprKnucklesJump1, 2);
global.ani_knuckles_jump_v2 = new animation(sprKnucklesJump2, [1, 2, 2, 2], 1);
global.ani_knuckles_jump = [global.ani_knuckles_jump_v0, global.ani_knuckles_jump_v1, global.ani_knuckles_jump_v2];

global.ani_knuckles_hurt_v0 = new animation(sprKnucklesHurt0, [3, 8, 8, 8, 8], -1);
global.ani_knuckles_hurt_v1 = new animation(sprKnucklesHurt1, 5, -1);
global.ani_knuckles_hurt = [global.ani_knuckles_hurt_v0, global.ani_knuckles_hurt_v1];

global.ani_knuckles_dead_v0 = new animation(sprKnucklesDead, [3, 3, 12, 2, 3, 3], 4);

global.ani_knuckles_trick_up_v0 = new animation(sprKnucklesTrickUp0, [1, 2, 1], -1);
global.ani_knuckles_trick_up_v1 = new animation(sprKnucklesTrickUp1, [4, 4, 8, 8, 8], -1);
global.ani_knuckles_trick_up_v2 = new animation(sprKnucklesTrickUp2, [7, 6, 3, 3, 3], 2);
global.ani_knuckles_trick_up = [global.ani_knuckles_trick_up_v0, global.ani_knuckles_trick_up_v1, global.ani_knuckles_trick_up_v2];

global.ani_knuckles_trick_down_v0 = new animation(sprKnucklesTrickDown0, [2, 3, 2, 2], -1);
global.ani_knuckles_trick_down_v1 = new animation(sprKnucklesTrickDown1, 2);
global.ani_knuckles_trick_down_v2 = new animation(sprKnucklesTrickDown2, [1, 1, 1, 1, 4, 2, 2], -1);
global.ani_knuckles_trick_down = [global.ani_knuckles_trick_down_v0, global.ani_knuckles_trick_down_v1, global.ani_knuckles_trick_down_v2];

global.ani_knuckles_trick_front_v0 = new animation(sprKnucklesTrickFront0, [2, 2, 2, 2, 4], -1);
global.ani_knuckles_trick_front_v1 = new animation(sprKnucklesTrickFront1, 2, 3);
global.ani_knuckles_trick_front_v2 = new animation(sprKnucklesTrickFront2, 2, -1);
global.ani_knuckles_trick_front = [global.ani_knuckles_trick_front_v0, global.ani_knuckles_trick_front_v1, global.ani_knuckles_trick_front_v2];

global.ani_knuckles_trick_back_v0 = new animation(sprKnucklesTrickBack0, [2, 2, 4], -1);
global.ani_knuckles_trick_back_v1 = new animation(sprKnucklesTrickBack1, [2, 2, 3, 3], 2);
global.ani_knuckles_trick_back = [global.ani_knuckles_trick_back_v0, global.ani_knuckles_trick_back_v1];

global.ani_knuckles_spring_v0 = new animation(sprKnucklesSpring0, 3, 1);
global.ani_knuckles_spring_v1 = new animation(sprKnucklesSpring1, 3, -1);
global.ani_knuckles_spring_v2 = new animation(sprKnucklesSpring2, 3);
global.ani_knuckles_spring = [global.ani_knuckles_spring_v0, global.ani_knuckles_spring_v1, global.ani_knuckles_spring_v2];

global.ani_knuckles_spring_twirl_v0 = new animation(sprKnucklesSpringTwirl, [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 3, 3], 11);

global.ani_knuckles_glide_v0 = new animation(sprKnucklesGlide, 3);

#endregion