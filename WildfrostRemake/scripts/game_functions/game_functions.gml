/// @func Starts the battle officially after the deployment phase
function start_battle()
{
	// Change phase to casting
	global.current_phase = Phase.Casting;
	
	// Spawn first wave
	start_next_wave();
	
	// Get rid of button
	instance_destroy(id);
	
	// Draw first 6 cards
	draw_card(6, global.deck);
}

function start_combat(_team)
{
	f("Starting combat...");
	// Loop through team units currently placed on the grid
	for (var i = 0; i < 6; i++) {
	    var u = global.current_grid[_team][i];
	    if (instance_exists(u)) {
	        //f($"Team: {_team} -- Slot: {i+1}");
			
			// Decrease time counter
			u.stats.time--;
			
			// Check if it is 0
			if (u.stats.time <= 0)
			{
				// Attack frontmost enemy unit
				var _target = find_attack_target(u);
				if (instance_exists(_target)) 
				{
			        unit_attack(_target, u);
					
			        if (instance_exists(_target) && _target.stats.hp <= 0) 
					{
			            kill_unit(_target);
			        }
			    }
				
				// Reset time counter
				u.stats.time = global.card_data[u.card_id].time;
			}
	    }
	}
}

/// @func Ends the player's turn and starts combat
function end_turn()
{
	f("Turn ended");
	// Change phase to combat
	global.current_phase = Phase.Comabt;
	
	// Trigger combat phase logic
	// 1. Loop through all slots
	// 2. Decrement their time counters
	// 3. If counter reaches 0, perform attack behavior
	
	start_combat(Team.Enemy);
	start_combat(Team.Player);
	
	// Combat phase is done and we can now cast again
	global.current_phase = Phase.Casting;
}

function victory()
{
	room_goto(rmVictory);
}

function fail()
{
	room_goto(rmFail);
}