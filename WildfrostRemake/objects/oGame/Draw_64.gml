draw_set_settings(fa_left, fa_top, c_white);
draw_text(10, 10, "FPS: " + string(round(fps)));
draw_text(10, 30, "Phase: " + string(get_phase(global.current_phase)));