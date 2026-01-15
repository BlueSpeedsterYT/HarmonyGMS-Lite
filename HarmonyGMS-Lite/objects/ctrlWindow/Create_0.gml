/// @description Initialize
scale = 3;

// Resize
window_set_size(CAMERA_WIDTH * scale, CAMERA_HEIGHT * scale);
surface_resize(application_surface, CAMERA_WIDTH, CAMERA_HEIGHT);
display_set_gui_size(CAMERA_WIDTH, CAMERA_HEIGHT);
window_center();