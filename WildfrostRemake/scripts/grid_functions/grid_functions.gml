function slot_index(_team, _row, _col) 
{
    if (_team == Team.Enemy) {
        // enemy cols are 3..5; convert to 0..2
        var c = _col - 3;
        return (_row * 3) + c;          // 0..5
    } else {
        // player wants right->left (2,1,0)
        var c = 2 - _col;
        return (_row * 3) + c;          // 0..5
    }
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

    _unit.team = undefined;
    _unit.row  = undefined;
    _unit.col  = undefined;
}