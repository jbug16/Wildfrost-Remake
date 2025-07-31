#region Enums

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

// An array that stores all cards in the game with their properties
global.card_data = array_create(CardID.Size);

// An array to hold the current cards in hand
global.current_hand = [];

// An array to hold current cards on the grid
global.current_grid = [];

// UI helpers
global.dragged_card = noone;

#endregion

#region Macros

// Debug
#macro f show_debug_message

// Helpers for drawing cards in hand
#macro HAND_START_Y  600
#macro HAND_SPACING  (104 + 20) // sprite width + space

#endregion