/// @description Render
var cam_x = camera_get_view_x(CAMERA_ID);
var cam_y = camera_get_view_y(CAMERA_ID);
var cam_x_sa2 = (cam_x * 256);
var cam_y_sa2 = (cam_y * 256);

draw_sprite_tiled_area(sprLeafForestBackground, 0, 0, 0, cam_x, cam_y, CAMERA_WIDTH, 72);
draw_sprite_tiled_area(sprLeafForestBackground, 0, (cam_x_sa2 >> 7) div 256, ((cam_y_sa2 >> 8) div 256) + 72, cam_x, cam_y + 72, CAMERA_WIDTH, 86);
draw_sprite_tiled_area(sprLeafForestBackground, 1, (cam_x_sa2 >> 6) div 256, ((cam_y_sa2 >> 9) div 256), cam_x, cam_y, CAMERA_WIDTH, CAMERA_HEIGHT);