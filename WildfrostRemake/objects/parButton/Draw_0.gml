// Choose color
var col = c_white;
if (hover) col = c_ltgrey;
if (pressed) col = c_grey;
if (!enabled) col = c_black;

// Button background
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, col, 1);

// Text
draw_set_settings(fa_center, fa_middle);
draw_text(x, y, label);