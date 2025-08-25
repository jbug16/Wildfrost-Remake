#region Card Initialization

/// @function Initializes all of the card's data including: name, type, sprite, hp, etc.
function init_card_data()
{
	#region Units
	
	// Commanders
	global.card_data[CardID.CO_Toppit] = 
	{ 
		name: "Toppit",
	    type: CardType.Unit, 
		subtype: UnitType.Commander, 
	    sprite: sCommanderCard,
		keywords: [],
		
		hp: 10,
		attack: 3,
		time: 2
	};
	
	// Mercenaries
	global.card_data[CardID.ME_Foxee] = 
	{ 
		name: "Foxee",
	    type: CardType.Unit, 
		subtype: UnitType.Mercenary,
	    sprite: sMercenaryCard,
		keywords: [],
		
		hp: 6,
		attack: 4,
		time: 3
	};
	
	#endregion
	
	#region Spells
	
	// Damage
	global.card_data[CardID.SP_ScrappySword] = 
	{ 
		name: "Scrappy Sword",
	    type: CardType.Spell, 
		subtype: SpellType.Damage,
	    effect: spell_attack, 
	    sprite: sSpellCard,
		keywords: [Keyword.Flash],
		
		attack: 4
	};
	
	// Heal
	global.card_data[CardID.SP_PinkberryJuice] = 
	{ 
		name: "Pinkberry Juice",
	    type: CardType.Spell,
		subtype: SpellType.Heal,
	    effect: spell_heal, 
	    sprite: sSpellCard,
		keywords: [Keyword.Flash],
		
		attack: 2
	};
	
	#endregion
}

#endregion

#region Card Lookup Functions

/// @function Returns an array of cards with this specific type
function get_cards_by_type(_type, _subtype = undefined) 
{
    var _result = [];
    
    for (var i = 0; i < CardID.Size; i++) 
	{
        var _c = global.card_data[i];

        if (!is_undefined(_c) && _c.type == _type) 
		{
            // If a subtype was provided, check it too
            if (is_undefined(_subtype) || _c.subtype == _subtype) 
			{
                array_push(_result, i);
            }
        }
    }
    
    return _result;
}

/// @function Returns an array of cards with this keyword
function get_cards_by_keyword(_keyword) 
{
    var _result = [];

    for (var i = 0; i < CardID.Size; i++) 
	{
        var _c = global.card_data[i];

        if (!is_undefined(_c) && array_length(_c.keywords) > 0) 
		{
            if (array_contains(_c.keywords, _keyword)) 
			{
                array_push(_result, i);
            }
        }
    }

    return _result;
}

/// @function Returns whether this card has a stat defined
function has_stat(_stat)
{
	return _stat != -1;
}

function has_keyword(_inst, _keyword)
{
	var _data = global.card_data[_inst.card_id];
	return array_contains(_data.keywords, _keyword);
}

function array_index_of(_arr, _val) 
{
    var n = array_length(_arr);
    for (var i = 0; i < n; i++) if (_arr[i] == _val) return i;
    return -1;
}

#endregion

#region Card Utility Functions

/// @function Adds a keyword to a card
function add_keyword_to_card(_id, _keyword) 
{
    var _card = global.card_data[_id];

    if (is_undefined(_card)) return; // safety check

    // Only add if it doesn't already exist
    if (!array_contains(_card.keywords, _keyword)) 
	{
        array_push(_card.keywords, _keyword);
    }
}

/// @function Removes a keyword from a card
function remove_keyword_from_card(_id, _keyword)
{
	var _card = global.card_data[_id];

    if (is_undefined(_card)) return; // safety check

    // Only remove if the keyword exists
    if (array_contains(_card.keywords, _keyword)) 
	{
        array_delete(_card.keywords, _keyword, 1);
    }
}

/// @function Returns a struct for card stats
function create_stats(_hp, _atk, _time, _spr, _team, _type) 
{
    return {
        hp: _hp,
        attack: _atk,
        time: _time,
        sprite: _spr,
        team: _team,
        type: _type
    };
}

#endregion

#region Card Creation

/// @function Returns a card instance with defined stats
function create_card(_id, _team = Team.Player, _x = 0, _y = 0) 
{
    var data = global.card_data[_id];

    var card = instance_create_layer(_x, _y, "Cards", oCard);

    card.card_id = _id;
    card.card_type = data.type;
    card.sprite_index = data.sprite;
	card.can_drag = _team == Team.Player ? true : false;
	card.team = _team;

    card.stats = create_stats(
        variable_struct_exists(data, "hp") ? data.hp : -1,
        variable_struct_exists(data, "attack") ? data.attack : -1,
        variable_struct_exists(data, "time") ? data.time : -1,
        variable_struct_exists(data, "sprite") ? data.sprite : undefined,
        variable_struct_exists(data, "team") ? _team : undefined,
        variable_struct_exists(data, "subtype") ? data.subtype : undefined
    );

    //f($"Created: {data.name} for Team {get_team(_team)}");

    return card;
}

#endregion

#region Gameplay

function remove_card_from_hand(_inst)
{
	var idx = array_index_of(global.current_hand, _inst);
    if (idx != -1) array_delete(global.current_hand, idx, 1);
	reposition_cards();
}

/// @function Place the unit card on the grid and update the player's hand
function play_unit_card(_inst, _slot) 
{
	var _data = global.card_data[_inst.card_id];
	
	// Place card on the grid in the correct slot
    grid_place(_inst, Team.Player, _slot.grid_row, _slot.grid_col);
	
	// Update player's hand
	remove_card_from_hand(_inst);
	
	// Check for any keywords
	// Flash	- permanent “free” play. no matter how many times you play it, it won’t end your turn
	// Flicker	- one-time “free” play. after that first use, the flicker property is removed from the card
	if (_data.subtype == UnitType.Commander) return;
	if (!has_keyword(_inst, Keyword.Flash) and !has_keyword(_inst, Keyword.Flicker)) end_turn();
	else if (has_keyword(_inst, Keyword.Flicker)) remove_keyword_from_card(_inst.card_id, Keyword.Flicker);
}

/// @func Execute the spell card's effect and update the player's hand
function play_spell_card(_inst)
{
	var _data = global.card_data[_inst.card_id];
	
	// Play spell effect
	if (!is_undefined(_data.effect)) 
	{
        script_execute(_data.effect, _inst.spell_target);
    }
	
	// Check for any keywords
	if (!has_keyword(_inst, Keyword.Flash) and !has_keyword(_inst, Keyword.Flicker)) end_turn();
	else if (has_keyword(_inst, Keyword.Flicker)) remove_keyword_from_card(_inst.card_id, Keyword.Flicker);
	
	// Update player's hand
	remove_card_from_hand(_inst);
	instance_destroy(_inst);
	
	// Handle death
	if (spell_target.stats.hp <= 0) kill_unit(spell_target);
}

#endregion