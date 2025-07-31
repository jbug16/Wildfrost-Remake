// Inherit the parent event
event_inherited();

// Start dragging
if (mouse_check_button_pressed(mb_left) && hovered) 
{
	// Track drag
    dragging = true;
	global.dragged_card = id;
}