/// @function Defines a targetted attack for units
function unit_attack(_target, _attacker)
{
	if (!instance_exists(_target) || !instance_exists(_attacker)) return;
	
	var _attacker_data = global.card_data[_attacker.card_id];
	var _target_data = global.card_data[_target.card_id];
    var _amt  = _attacker_data.attack;
	
	f($"{get_team(_attacker.team)}'s {_attacker_data.name} dealt {_amt} to {get_team(_target.team)}'s {_target_data.name}!");
	
	_target.stats.hp -= _amt;
}

/// @func Kill and clean up a unit (enemy or player)
function kill_unit(_inst)
{
    if (!instance_exists(_inst)) return;

    var _data = global.card_data[_inst.card_id];

    // Free the slots
    grid_remove(_inst);

    // Pull back-row forward if front died
    //if (_inst.team == Team.Player || _inst.team == Team.Enemy) {
    //    grid_shift_column_forward(_inst.team, _inst.col);
    //}

    // Clear any global references that might still point at this unit
    if (instance_exists(spell_target) && spell_target == _inst) spell_target = noone;
    if (global.dragged_obj == _inst) global.dragged_obj = noone;

    // Announce & destroy
    f($"{_data.name} died!");
    instance_destroy(_inst);

    //// Win/Lose / Next-wave checks
	//var was_boss      = (variable_struct_exists(_data, "is_boss") && _data.is_boss);
    //var was_commander = (_data.subtype == UnitType.Commander);
    //if (was_commander && _inst.team == Team.Player) {
    //    defeat(); // player commander died
    //    return;
    //}
    //if (was_boss) {
    //    victory(); // boss died
    //    return;
    //}

    //// If no enemies remain, advance waves or win
    //if (!any_enemies_alive()) {
    //    if (global.wave >= total_waves) victory();
    //    else with (oWaveManager) alarm[0] = room_speed * 1; // small delay → next wave
    //}
}