/// @description Render
if (not DEBUG_ENABLED) exit;

var vx = camera_get_view_x(CAMERA_ID) + CAMERA_WIDTH_CENTER;
var vy = camera_get_view_y(CAMERA_ID) + CAMERA_HEIGHT_CENTER;
draw_rectangle(vx div 1 - CAMERA_X_BORDER, vy div 1 - CAMERA_Y_BORDER, vx div 1 + CAMERA_X_BORDER, vy div 1 + CAMERA_Y_BORDER, true);