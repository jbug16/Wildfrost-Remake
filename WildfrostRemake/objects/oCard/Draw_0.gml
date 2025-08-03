draw_sprite_ext(sprite_index, 0, x, y, current_scale, current_scale, 0, c_white, 1);

// Draw stats
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

var box_w = 20;
var box_h = 28;

// Attack box
var atk_center_x = x - (sprite_width * 0.5 * current_scale) + ((4 + box_w * 0.5) * current_scale);
var atk_center_y = y - (sprite_height * 0.5 * current_scale) + ((4 + box_h * 0.5) * current_scale);

// HP box
var blue_x = sprite_width - 4 - box_w;
var hp_center_x = x - (sprite_width * 0.5 * current_scale) + ((blue_x + box_w * 0.5) * current_scale);
var hp_center_y = atk_center_y;

var text_h = string_height(string(stats.attack));
atk_center_y -= text_h * 0.5 * current_scale;
hp_center_y -= text_h * 0.5 * current_scale;

// Attack
if (has_stat(stats.attack))
    draw_text_ext_transformed(atk_center_x, atk_center_y, string(stats.attack), 0, 100, current_scale, current_scale, 0);

// HP
if (has_stat(stats.hp))
	draw_text_ext_transformed(hp_center_x, hp_center_y, string(stats.hp), 0, 100, current_scale, current_scale, 0);

// Time
if (has_stat(stats.time))
	draw_text_ext_transformed(x, y - box_h + sprite_height/2, string(stats.time), 0, 100, current_scale, current_scale, 0);