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
	
	// Check if dropped on a valid player slot
	var _slot = instance_place(x, y, oSlot);

	if (_slot != noone && !_slot.occupied && _slot.team == "player")
	{
		// Snap card to slot position
		var _data = global.card_data[card_id];

		spawn_unit(id, _slot.x, _slot.y, _slot.team);

		// Mark slot as occupied
		_slot.occupied = true;
		_slot.unit_ref = id;

		play_card(id);
	}
	else
	{
		reposition_cards(); // return card to hand
	}
}

// Handle dragging
if (dragging) 
{
    x = mouse_x - drag_offset_x;
    y = mouse_y - drag_offset_y;
}