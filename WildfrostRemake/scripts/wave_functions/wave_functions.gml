/// @func Spawns enemies for the wave
function start_next_wave()
{
	// Spawn enemies
	global.wave++;
	if (global.wave > oWaveManager.total_waves) return;
	
	f($"Starting wave {global.wave}");
	
	var _enemies = oWaveManager.wave_enemies[global.wave];
	for (var i = 0; i < array_length(_enemies); i++) 
	{
	    spawn_enemy(_enemies[i]);
	}
}

/// @func Creates the enemy unit and places it on the grid
function spawn_enemy(_enemy)
{
	// 1) Create a unit from a card id (same as player)
	var _unit = create_card(_enemy.card_id, Team.Enemy);
	_unit.state = State.InBattle;

	// 2) Place it using the same grid placement
	grid_place(_unit, Team.Enemy, _enemy.row, _enemy.col);
		
	// 3) Spawn the enemy
	var _slot = get_slot_inst(Team.Enemy, _enemy.row, _enemy.col);
	if (_slot != noone) 
	{
	    with (_slot) 
		{
	        occupied = true;
	        unit_ref = _unit;
	    }
		
	    _unit.x = _slot.x;
	    _unit.y = _slot.y;
	}
}