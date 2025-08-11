#region Enums

// Determines what team the card is on
enum Team {
	Enemy,
	Player
}

// Sets the different stages of battle
enum Phase {
	Deployment,
	Casting,
	Comabt
}

// Determines what state the card is in
enum State {
	InHand,
	InBattle
}

// Determines how the card can be played
enum CardType {
	Unit,
	Spell
}

// Determines how the units behaves
enum UnitType {
	Commander,
	Mercenary,
	Summon
}

// Determines the spell's effect
enum SpellType {
	Buff,
	Heal,
	Damage
}

// Adds properties to cards
enum Keyword {
	Flicker,
	Flash,
	Halo
}

// Allows all cards to referenced by name
enum CardID {
    CO_Toppit,			// Commander
	ME_Foxee,			// Mercenary
	SP_ScrappySword,	// Spell
	SP_PinkberryJuice,
	Size				// end of list
}

#endregion

#region Globals

// Random deck of cards
global.deck = noone;

// An array that stores all cards in the game with their properties
global.card_data = array_create(CardID.Size);

// An array to hold the current cards in hand
global.current_hand = [];

// An array to hold current cards on the grid
global.current_grid = array_create(2);
global.current_grid[Team.Enemy] = array_create(6, noone);
global.current_grid[Team.Player] = array_create(6, noone);

// Keeps track of the phase of the battle
global.current_phase = noone;

// UI helpers
global.dragged_obj = noone;

#endregion

#region Macros

// Debug
#macro f show_debug_message

// UI helpers
#macro HAND_SPACING  (104 + 20) // sprite width + space

#endregion