/// @description Fill screen with black
draw_set_alpha(image_alpha);
draw_rectangle_color(0, 0, CAMERA_WIDTH, CAMERA_HEIGHT, transition_color, transition_color, transition_color, transition_color, false);
draw_set_alpha(1);