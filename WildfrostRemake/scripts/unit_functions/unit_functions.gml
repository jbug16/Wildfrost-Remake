function kill_unit(_id)
{
	// TEST FUNCTION
	// DOES NOT WORK
	
	if (!instance_exists(_id)) return; // safety check

    var data = global.card_data[_id.card_id];

    if (is_undefined(data)) return;
	
	// find the slot this unit is in
	var _slot = instance_place(x, y, oSlot);

	if (_slot != noone)
	{
		_slot.occupied = false;
		_slot.unit_ref = noone;
	}

    f($"{data.name} died!");

    instance_destroy(_id); // actually remove the unit
}