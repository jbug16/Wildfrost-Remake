// If the card is in the player's hand
if (state == "hand")
{
    // Start dragging
    if (mouse_check_button_pressed(mb_left) && hovered) 
    {
        dragging = true;
        global.dragged_card = id;

        drag_offset_x = mouse_x - x;
        drag_offset_y = mouse_y - y;
        depth = -10000;
    }

    // Stop dragging
    if (mouse_check_button_released(mb_left) && global.dragged_card == id) 
    {
        dragging = false;
        global.dragged_card = noone;
        depth = base_depth;

        // Check for valid slot
        var _slot = instance_place(x, y, oSlot);

        if (_slot != noone && !_slot.occupied && _slot.team == "player")
        {
            // Move this card to the slot
            x = _slot.x;
            y = _slot.y;

            state = "field"; // ✅ Switch to unit mode
            depth = 0;

            _slot.occupied = true;
            _slot.unit_ref = id;

            play_card(id); // remove from hand array, etc.
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
}
else if (state == "field")
{
    // Unit behavior goes here
    // Example: combat AI, cooldown, etc.
}