#region Scaling animation

// Check if mouse is over card
hovered = position_meeting(mouse_x, mouse_y, id);

// Scale logic
if (dragging)
    target_scale = drag_scale;
else if (hovered && state == State.InHand)
    target_scale = hover_scale; 
else
    target_scale = 1;
	
current_scale = lerp(current_scale, target_scale, 0.25);

#endregion

#region State machine

switch (state)
{
	#region In Hand
	
	case State.InHand:
		// Start dragging
	    if (mouse_check_button_pressed(mb_left) && hovered) 
	    {
	        dragging = true;
	        global.dragged_card = id;

	        drag_offset_x = mouse_x - x;
	        drag_offset_y = mouse_y - y;
	    }

	    // Stop dragging
	    if (mouse_check_button_released(mb_left) && global.dragged_card == id) 
	    {
	        dragging = false;
	        global.dragged_card = noone;

			// Place on grid for unit cards
	        if (card_type == CardType.Unit) 
		    {
				// Snap to grid slot
		        var _slot = instance_place(x, y, oSlot);

		        if (_slot != noone && !_slot.occupied && _slot.team == "player")
		        {
		            x = _slot.x;
		            y = _slot.y;

		            _slot.occupied = true;
		            _slot.unit_ref = id;

					play_card(id);
		            state = State.InBattle;
		        }
		        else reposition_cards();
		    }
			// Cast spell for spell cards
			else if (card_type == CardType.Spell) 
		    {
		        if (instance_exists(spell_target))
		        {
		            play_card(id);
		        }
		        else reposition_cards();
		    }
	    }

	    // Handle dragging
	    if (dragging) 
	    {
			if (card_type == CardType.Spell) 
			{
				// Find the card under the cursor
			    var _target = instance_position(mouse_x, mouse_y, oCard);

			    // Only set as spell target if it's a field card
			    if (instance_exists(_target) && _target.state == State.InBattle) 
			        spell_target = _target;
			    else 
			        spell_target = noone;
				return;
			}
			
	        x = mouse_x - drag_offset_x;
	        y = mouse_y - drag_offset_y;
	    }
		else spell_target = noone;
		break;
		
	#endregion
	
	#region In Battle
	
	case State.InBattle:
	
		break;
		
	#endregion
}