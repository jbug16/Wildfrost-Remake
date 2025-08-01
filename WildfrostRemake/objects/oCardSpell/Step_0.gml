// Inherit the parent event
event_inherited();

// Start dragging
if (mouse_check_button_pressed(mb_left) && hovered) 
{
	// Track drag
    dragging = true;
	global.dragged_card = id;
}

// Stop dragging
if (mouse_check_button_released(mb_left) && global.dragged_card == id) 
{
    dragging = false;
    global.dragged_card = noone;

	// Check target
	if (spell_target != noone)
	{
		play_card(id);
	}
}

// Handle arrow position
if (dragging) 
{
	var _dx = mouse_x - x;
	var _dy = mouse_y - y;

    arrow_length = point_distance(x, y, mouse_x, mouse_y);
    arrow_angle = point_direction(x, y, mouse_x, mouse_y);

    // Check if mouse is over a unit
    spell_target = instance_position(mouse_x, mouse_y, parUnit);
}
else spell_target = noone;