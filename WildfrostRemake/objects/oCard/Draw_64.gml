if (!dragging) exit;

// Draw card sprite
draw_sprite_ext(sprite_index, 0, x, y, current_scale, current_scale, 0, c_white, 1);

// Draw stats
draw_set_settings(fa_center, fa_middle);
draw_stats();

// Draw spell arrow
draw_spell_arrow();