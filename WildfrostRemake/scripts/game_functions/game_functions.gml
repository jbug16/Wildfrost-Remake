/// @func Starts the battle officially after the deployment phase
function start_battle()
{
	// Change phase to casting
	global.current_phase = Phase.Casting;
	
	// Spawn first wave
	
	// Get rid of button
	instance_destroy(id);
	
	// Draw first 6 cards
	draw_card(6, global.deck);
}

/// @func Ends the player's turn
function end_turn()
{
	// Change phase to combat
	global.current_phase = Phase.Comabt;
	
	// Trigger combat phase logic:
	// 1. Loop through all units
	// 2. Decrement their time counters
	// 3. If counter reaches 0, perform attack behavior
	// 4. Ensure units can die and are removed from the slot when hp ≤ 0
}