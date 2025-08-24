function slot_index(_team, _row, _col) 
{
    return _row * 3 + _col; // 0..5
}

function get_slot_inst(_team, _row, _col) 
{
    var want_col = (_team == Team.Enemy) ? (_col + 3) : _col;
    var result = noone;
    with (oSlot) if (team == _team && grid_row == _row && grid_col == want_col) { result = id; break; }
    return result;
}

function grid_place(_unit, _team, _row, _col) 
{
    var idx = slot_index(_team, _row, _col);
    global.current_grid[_team][idx] = _unit;

    _unit.team = _team;
    _unit.row  = _row;
    _unit.col  = _col;
}

function grid_remove(_unit) 
{
    if (is_undefined(_unit.team)) return;
    var idx = slot_index(_unit.team, _unit.row, _unit.col);
    if (idx >= 0) global.current_grid[_unit.team][idx] = noone;
	
	var _slot = get_slot_inst(_unit.team, _unit.row, _unit.col);
	if (_slot != noone) 
	{
	    _slot.occupied = false;
	    if (_slot.unit_ref == _unit) _slot.unit_ref = noone;
	}

    _unit.team = undefined;
    _unit.row  = undefined;
    _unit.col  = undefined;
}

function get_front_slot(_team, _row)
{
	var _col = _team == Team.Enemy ? 0 : 2;
    var direct = get_slot_inst(_team, _row, _col);
    if (instance_exists(direct.unit_ref)) return direct.unit_ref;
	var indirect = get_slot_inst(_team, abs(_row - 1), _col);
    return instance_exists(indirect.unit_ref) ? indirect.unit_ref : noone;
}

function find_attack_target(_attacker)
{
	var _other_team = (_attacker.team == Team.Player) ? Team.Enemy : Team.Player;
	
	// Get the unit of the opposite team that is first in the same row
	// Or the first in the other row if the other row is empty
	var _target = get_front_slot(_other_team, _attacker.row);
	if (instance_exists(_target)) return _target;
}