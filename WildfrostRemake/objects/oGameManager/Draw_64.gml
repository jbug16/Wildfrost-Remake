if (!global.dev_mode) exit; // does not run the code below if we are not in devmode

// Drawing any debug stats to the screen
draw_set_settings(fa_left, fa_top, c_white);

draw_rectangle(0, 0, 200, 90, false); // background box

draw_set_settings(fa_left, fa_top, c_black);

draw_text(10, 10, "----- DEBUG PANEL -----");
draw_text(10, 30, "FPS: " + string(round(fps)));
draw_text(10, 50, "Phase: " + string(get_phase(global.current_phase)));
draw_text(10, 70, "Wave: " + string(global.wave));