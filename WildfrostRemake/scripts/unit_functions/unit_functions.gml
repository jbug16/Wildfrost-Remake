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
	
	f($"{get_team(_inst.team)}'s {_data.name} died!");

    // Check if the unit killed was a commander
	// If the player's CO dies, the player loses.
	// If the enemy's CO dies, the player wins.
    var was_commander = (_data.subtype == UnitType.Commander);
    if (was_commander)
	{
		if (_inst.team == Team.Enemy)
		{
			victory();
		}
        else if (_inst.team == Team.Player)
		{
			fail();
		}
    }
	
	// Clean-up
	
	// Save needed data
	var _team = _inst.team;
	var _behind = get_unit_behind(_inst);
	
	// Free the slots
    grid_remove(_inst);
	
	// Clear any global references that might still point at this unit
	with (_inst) if (instance_exists(spell_target) && spell_target == _inst) spell_target = noone;
    if (global.dragged_obj == _inst) global.dragged_obj = noone;
	
	// Destroy instance
    instance_destroy(_inst);
	
	// Move unit behind to front
	advance_unit_toward_front(_behind);
	fill_all_gaps(_team);
	
	// If no enemies remain, go to next wave
    if (!any_enemies_alive())
	{
		//start_next_wave();
		f("Starting next wave...");
		with (oWaveManager) alarm[0] = 60 * 2; // 2 sec delay -> next wave
    }
}