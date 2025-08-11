function kill_unit(_inst)
{
	// TEST FUNCTION
	// DOES NOT WORK

    var _data = global.card_data[_inst.card_id];
	
	// find the slot this unit is in
	var _slot = instance_place(x, y, oSlot);

	if (_slot != noone)
	{
		_slot.occupied = false;
		_slot.unit_ref = noone;
	}
	
	grid_remove(_inst);

    f($"{_data.name} died!");

    instance_destroy(_inst); // actually remove the unit
}