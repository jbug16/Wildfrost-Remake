#region Card Movement

/// @func Scales the card based on dragging and hovering
function card_hover_effect(_normal_scale, _lerp_amt)
{
	// Check if mouse is over card
	hovered = position_meeting(mouse_x, mouse_y, id);

	// Scale logic
	if (dragging)
	    target_scale = drag_scale;
	else if (hovered && global.dragged_obj == noone)
	    target_scale = hover_scale; 
	else
	    target_scale = _normal_scale;
	
	current_scale = lerp(current_scale, target_scale, _lerp_amt);
}

/// @func The card will follow the player's mouse
function start_drag()
{
	if (mouse_check_button_pressed(mb_left) && hovered)
	{
		dragging = true;
		drag_offset_x = mouse_x - x;
		drag_offset_y = mouse_y - y;

		global.dragged_obj = id;
	}
}

/// @func Perform the dragging movement and lock to a target if this is a spell card
function update_drag()
{
	if (!dragging) return;

	if (card_type == CardType.Spell)
	{
		var _target = instance_position(mouse_x, mouse_y, oCard);

		if (instance_exists(_target) && _target.state == State.InBattle)
			spell_target = _target;
		else
			spell_target = noone;

		return; // do not move spell card during drag
	}

	x = mouse_x - drag_offset_x;
	y = mouse_y - drag_offset_y;
}

/// @func Play the card or place back into the player's hand
function stop_drag()
{
	var released = mouse_check_button_released(mb_left);
	if (!released) return;

	if (global.dragged_obj != id) return;

	dragging = false;
	global.dragged_obj = noone;

	var _target_slot = instance_place(x, y, oSlot);

	// get current slot (for repositioning or unoccupying later)
	var _current_slot = noone;
	with (oSlot)
	{
		if (occupied && unit_ref == other.id)
			_current_slot = id;
	}

	// valid new slot
	var is_valid_slot = (_target_slot != noone && !_target_slot.occupied && _target_slot.team == Team.Player);

	if (is_valid_slot)
	{
		// clear previous slot
		if (_current_slot != noone)
		{
			with (_current_slot)
			{
				occupied = false;
				unit_ref = noone;
			}
		}

		// snap to new slot
		x = _target_slot.x;
		y = _target_slot.y;

		_target_slot.occupied = true;
		_target_slot.unit_ref = id;

		// play if from hand
		if (state == State.InHand && card_type == CardType.Unit)
		{
			play_unit_card(id, _target_slot);
			state = State.InBattle;
		}
		else move_unit(id, _target_slot.grid_row, _target_slot.grid_col);
	}
	else
	{
		if (state == State.InHand)
		{
			if (card_type == CardType.Spell && instance_exists(spell_target))
				play_spell_card(id);
			else
				reposition_cards();
		}
		else if (state == State.InBattle && _current_slot != noone)
		{
			x = _current_slot.x;
			y = _current_slot.y;
		}
	}
}