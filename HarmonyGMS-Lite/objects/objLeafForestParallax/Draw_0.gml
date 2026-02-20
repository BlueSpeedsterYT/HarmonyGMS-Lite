/// @description Render
var cam_x = camera_get_view_x(CAMERA_ID);
var cam_y = camera_get_view_y(CAMERA_ID);

draw_sprite_tiled_area(sprLeafForestBackground, 0, 0, 0, cam_x, cam_y, CAMERA_WIDTH, 72);
draw_sprite_tiled_area(sprLeafForestBackground, 0, (cam_x div 128), (cam_y div 256) + 72, cam_x, cam_y + 72, CAMERA_WIDTH, 86);
draw_sprite_tiled_area(sprLeafForestBackground, 1, (cam_x div 64), (cam_y div 512), cam_x, cam_y, CAMERA_WIDTH, 240);