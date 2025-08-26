function slot_index(_row, _col) 
{
	if (_row == undefined || _col == undefined) return;
	
    return _row * 3 + _col; // 0..5
}

function get_slot_inst(_team, _row, _col) 
{
    var want_col = (_team == Team.Enemy) ? (_col + 3) : _col;
    var result = noone;
    with (oSlot) if (team == _team && grid_row == _row && grid_col == want_col) { result = id; break; }
    return result;
}

function move_unit(_unit, _new_row, _new_col)
{
	if (!instance_exists(_unit)) return;
	
	// Store temp vars
	var _t = _unit.team;
	
	grid_remove(_unit);
	grid_place(_unit, _t, _new_row, _new_col);
}

function find_attack_target(_attacker) 
{
    var _other = (_attacker.team == Team.Player) ? Team.Enemy : Team.Player;
    var _face_col = front_edge_col(_other);			// always hit the other side’s front column
	
	if (_face_col == undefined) return noone;
	
    return get_front_unit(_attacker, _face_col);
}

/// @desc Returns true if there is at least one enemy unit on the grid
function any_enemies_alive() 
{
    for (var i = 0; i < 6; i++) 
	{
        var u = global.current_grid[Team.Enemy][i];
        if (instance_exists(u)) return true;
    }
    return false;
}

function grid_place(_unit, _team, _row, _col) 
{
    var idx = slot_index(_row, _col);
    global.current_grid[_team][idx] = _unit;

    _unit.team = _team;
    _unit.row  = _row;
    _unit.col  = _col;

    // mark slot + snap
    var s = get_slot_inst(_team, _row, _col);
    if (s != noone) 
	{
        s.occupied = true;
        s.unit_ref = _unit;
        _unit.x = s.x; _unit.y = s.y;
    }
	
	fill_all_gaps(_team);
}

function grid_remove(_unit) 
{
    if (!instance_exists(_unit)) return;
    if (is_undefined(_unit.team) || is_undefined(_unit.row) || is_undefined(_unit.col)) return;

    var t = _unit.team, r = _unit.row, c = _unit.col;

    var idx = slot_index(r, c);
    if (idx >= 0) {
        if (global.current_grid[t][idx] == _unit) global.current_grid[t][idx] = noone;
    }

    var s = get_slot_inst(t, r, c);
    if (s != noone) {
        s.occupied = false;
        if (s.unit_ref == _unit) s.unit_ref = noone;
    }

    _unit.team = undefined;
    _unit.row  = undefined;
    _unit.col  = undefined;
}

function get_front_unit(_attacker, _col) 
{
	if (!instance_exists(_attacker)) return noone;
	if (!variable_instance_exists(_attacker, "team") || !variable_instance_exists(_attacker, "row")) return noone;
	if (_col == undefined) return noone;
	
	var _team = abs(_attacker.team - 1);
	var _row = _attacker.row;
	
	// Get the unit of the opposite team that is first in the same row
	var _slot_index = slot_index(_row, _col);
	if (_slot_index == undefined) return noone;
	
    var _u = global.current_grid[_team][_slot_index];
    if (instance_exists(_u)) return _u;
	
	// Or the first in the other row if the other row is empty
	var _slot_index = slot_index(abs(_row - 1), _col);
	if (_slot_index == undefined) return noone;
	
    _u = global.current_grid[_team][_slot_index];
    return instance_exists(_u) ? _u : noone;
}

function get_unit_behind(_unit)
{
	if (!instance_exists(_unit)) return noone;
	
	var _t = _unit.team;
	var _r = _unit.row;
	var _c = _unit.col;
	
	var _behind_col = _c - 1;
	
	if (_behind_col < 0) return noone;
	
	var _behind = global.current_grid[_t][slot_index(_r, _behind_col)];
	return instance_exists(_behind) ? _behind : noone;
}

function front_edge_col(_team) 
{
    return (_team == Team.Player) ? 2 : 0;
}

function next_col_toward_front(_team, _col) 
{
    return (_team == Team.Player) ? min(_col + 1, 2) : max(_col - 1, 0);
}

function grid_cell_free(_team, _row, _col)
{
    return !instance_exists(global.current_grid[_team][slot_index(_row, _col)]);
}

/// true if there's at least one unit that can step toward the front (a gap ahead)
function team_has_movable_gap(_team) 
{
    // Player: check (c -> c+1) for c=0..1
    if (_team == Team.Player) {
        for (var r = 0; r < 2; r++) {
            for (var c = 0; c < 2; c++) {
                var here = global.current_grid[_team][slot_index(r, c)];
                var next = global.current_grid[_team][slot_index(r, c + 1)];
                if (instance_exists(here) && !instance_exists(next)) return true;
            }
        }
    } else { // Enemy: check (c -> c-1) for c=2..1
        for (var r = 0; r < 2; r++) {
            for (var c = 2; c > 0; c--) {
                var here = global.current_grid[_team][slot_index(r, c)];
                var next = global.current_grid[_team][slot_index(r, c - 1)];
                if (instance_exists(here) && !instance_exists(next)) return true;
            }
        }
    }
    return false;
}

/// @desc Move one step toward front edge if the next cell is free
function advance_unit_toward_front(_unit) 
{
    if (!instance_exists(_unit)) return false;

    var t = _unit.team, r = _unit.row, c = _unit.col;
    var front_c = front_edge_col(t);
    if (c == front_c) return false;

    var nc = next_col_toward_front(t, c);
    if (!grid_cell_free(t, r, nc)) return false;

    move_unit(_unit, r, nc);
    return true;
}

function fill_all_gaps(_team)
{
	for (var i = 0; i < 6; i++) 
	{
	    var u = global.current_grid[_team][i];
	    if (instance_exists(u)) 
		{
			advance_unit_toward_front(u);
		}
	}
}