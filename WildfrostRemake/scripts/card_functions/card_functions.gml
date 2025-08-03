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
		keywords: [],
		
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
		keywords: [],
		
		attack: 2
	};
	
	#endregion
}

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

/// @function Returns a struct for card stats
function create_stats(_hp, _atk, _time, _spr, _owner, _type) 
{
    return {
        hp: _hp,
        attack: _atk,
        time: _time,
        sprite: _spr,
        owner: _owner,
        type: _type
    };
}

/// @function Returns a card instance with defined stats
function create_card(_id, _x = oHandManager.x, _y = oHandManager.y) 
{
    var data = global.card_data[_id];

    var card = instance_create_layer(_x, _y, "Cards", oCard);

    card.card_id = _id;
    card.card_type = data.type;
    card.sprite_index = data.sprite;

    card.stats = create_stats(
        variable_struct_exists(data, "hp") ? data.hp : -1,
        variable_struct_exists(data, "attack") ? data.attack : -1,
        variable_struct_exists(data, "time") ? data.time : -1,
        variable_struct_exists(data, "sprite") ? data.sprite : undefined,
        "player",
        variable_struct_exists(data, "subtype") ? data.subtype : undefined
    );

    f($"Created: {data.name}");

    array_push(global.current_grid, card);
    return card;
}

/// @function These actions happen when a user plays a card
function play_card(_inst) 
{
    var _len = array_length(global.current_hand);

	for (var i = 0; i < _len; i++) 
	{
		// If this is the card we are dragging
		if (global.current_hand[i] == _inst) 
		{
			f("Deleting index: " + string(i));
			var _data = global.card_data[_inst.card_id];
			
			// Play spell effect
            if (_data.type == CardType.Spell) 
			{
                if (!is_undefined(_data.effect)) 
				{
                    script_execute(_data.effect, _inst.spell_target); 
                }
            }
			
			array_delete(global.current_hand, i, 1);
			instance_destroy(_inst);
			reposition_cards();
			
			break;
		}
	}
}

/// @function Returns whether this card has a stat defined
function has_stat(_stat)
{
	return _stat != -1;
}