if (!visible_btn) exit;

// choose color
var col = col_base;
if (hover) col = col_hover;
if (pressed) col = col_down;

// shadow
draw_set_alpha(0.2); 
draw_set_color(c_black);
draw_roundrect(x, y+2, x+w, y+h+2, false);
draw_set_alpha(1);

// body
draw_set_color(col);
draw_roundrect(x, y, x+w, y+h, false);

// text
draw_set_settings(fa_center, fa_middle, col_text);
draw_text(x + w*0.5, y + h*0.5, string(label));