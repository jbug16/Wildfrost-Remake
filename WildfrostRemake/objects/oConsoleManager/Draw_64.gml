// oConsoleManager: Draw GUI
if (!console.open) exit;

var w = display_get_gui_width();
var x1 = 16, y1 = 16;
var x2 = w - 16, y2 = y1 + (max_log_lines + 2) * row_h + 16;

draw_set_alpha(0.8);
draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, false);
draw_set_alpha(1);

// text
if (font_exists(font_console)) draw_set_font(font_console);
draw_set_color(c_white);

// log lines (from bottom of log)
var start = max(0, array_length(console.log) - max_log_lines);
for (var i = 0; i < min(max_log_lines, array_length(console.log)); i++) {
    draw_text(x1 + 10, y1 + 10 + i*row_h, console.log[start + i]);
}

// prompt
var prompt_y = y1 + 10 + max_log_lines * row_h;
var caret = (console.caret_timer div 20) mod 2 == 0 ? "|" : " ";
draw_set_color(c_green);
draw_text(x1 + 10, prompt_y, "> " + console.input + caret);
