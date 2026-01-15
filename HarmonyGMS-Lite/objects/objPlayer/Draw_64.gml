/// @description Debug
if (not ctrlGame.game_debug) exit;
if (player_index != 0) exit;
draw_set_font(global.font_debug);
draw_set_halign(fa_right);

var player_data = "";
player_data += $"State: {script_get_name(state)}\n\n";
player_data += $"Speed: {string_format(x_speed, 3, 2)} | {string_format(y_speed, 3, 2)}\n\n";
player_data += $"Direction: {string_format(direction, 3, 0)} | {string_format(local_direction, 3, 0)}\n\n";
player_data += $"Mask Direction: {mask_direction}\n\n";
player_data += $"Control Lock: {control_lock_time}\n\n";
player_data += $"Facing: {image_xscale}\n\n";
player_data += $"Spin Dash Charge: {spin_dash_charge}\n\n";
player_data += $"Step: {ctrlGame.game_time}\n\n";
player_data += $"Layer: {collision_layer}";

//draw_text_transformed(CAMERA_WIDTH - 16, 9, player_data, 0.7, 0.7, 0);

draw_set_halign(fa_left);