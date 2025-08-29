// Only use this draw event if the cards are NOT being dragged
// This is because Draw GUI always draws anything in that event on top of everything else
// (So we only want to draw the card on top of everything while we are dragging.)
if (dragging) exit;

// Draw card sprite
draw_sprite_ext(sprite_index, 0, x, y, current_scale, current_scale, 0, c_white, 1);

// Draw stats
draw_set_settings(fa_center, fa_middle);
draw_stats();