// Check if mouse is hovering over the card (use scaled sprite size)
var _half_w = sprite_width * 0.5 * current_scale;
var _half_h = sprite_height * 0.5 * current_scale;

hovered = (mouse_x > x - _half_w && mouse_x < x + _half_w &&
		   mouse_y > y - _half_h && mouse_y < y + _half_h);

// Scaling logic
if (hovered && global.dragged_unit == noone)
	target_scale = hover_scale_factor;
else
	target_scale = 1;

current_scale = lerp(current_scale, target_scale, 0.2);