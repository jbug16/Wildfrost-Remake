// Inherit the parent event
event_inherited();

// Start dragging
if (mouse_check_button_pressed(mb_left) && hovered) 
{
	// Track drag
    dragging = true;
	global.dragged_card = id;
	
	// Set variables for visuals
    drag_offset_x = mouse_x - x;
    drag_offset_y = mouse_y - y;
	depth = -10000;
}

// Stop dragging
if (mouse_check_button_released(mb_left) && global.dragged_card == id) 
{
	// Track drag
	dragging = false;
	global.dragged_card = noone;
	
	depth = base_depth;
	
	// Check position to see if we can place a unit on the grid
	if (place_meeting(x, y, oTestGrid)) // TODO: update this to only allow if the card is in a grid slot
	{
		var _data = global.card_data[card_id];
		
		spawn_unit(
            card_id,
			300 + (HAND_SPACING * card_id), //temp grid
			300,
            "player"
        );
		
		play_card(id);
	}
	else reposition_cards(); // place the card back into the player's hand
}

// Handle dragging
if (dragging) 
{
    x = mouse_x - drag_offset_x;
    y = mouse_y - drag_offset_y;
}