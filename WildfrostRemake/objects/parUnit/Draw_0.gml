draw_sprite_ext(sprite_index, 0, x, y, current_scale, current_scale, 0, c_white, 1);

// Center text alignment
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);

// Box size
var box_w = 20;
var box_h = 28;

// --- ATTACK BOX (red) ---
var atk_center_x = x - (sprite_width * 0.5 * current_scale) + ((4 + box_w * 0.5) * current_scale);
var atk_center_y = y - (sprite_height * 0.5 * current_scale) + ((4 + box_h * 0.5) * current_scale);

// --- HP BOX (blue) ---
var blue_x = sprite_width - 4 - box_w;
var hp_center_x = x - (sprite_width * 0.5 * current_scale) + ((blue_x + box_w * 0.5) * current_scale);
var hp_center_y = atk_center_y; // same Y as attack box

// Get height of the current text at base scale
var text_h = string_height(string(stats.attack));

// Adjust Y so scaling stays centered
var atk_center_y_adj = atk_center_y - (text_h * 0.5 * current_scale);
var hp_center_y_adj  = hp_center_y  - (text_h * 0.5 * current_scale);

// Draw text centered
draw_text_ext_transformed(atk_center_x, atk_center_y_adj, string(stats.attack), 0, 100, current_scale, current_scale, 0);
draw_text_ext_transformed(hp_center_x,  hp_center_y_adj,  string(stats.hp),     0, 100, current_scale, current_scale, 0);