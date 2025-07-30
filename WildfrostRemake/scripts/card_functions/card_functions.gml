function init_card_data()
{
	#region Units
	
	// Commanders
	global.card_data[CardID.CO_Toppit] = 
	{ 
		name: "Toppit",
	    type: CardType.Unit, 
		subtype: UnitType.Commander,
	    unit_object: oUnitCommander, 
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
	    unit_object: oUnitMercenary, 
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
		keywords: []
	};
	
	// Heal
	global.card_data[CardID.SP_PinkberryJuice] = 
	{ 
		name: "Pinkberry Juice",
	    type: CardType.Spell,
		subtype: SpellType.Heal,
	    effect: spell_heal, 
	    sprite: sSpellCard,
		keywords: []
	};
	
	#endregion
}

function get_cards_by_type(_type, _subtype = undefined) 
{
    var _result = [];
    
    for (var i = 0; i < CardID.Size; i++) 
	{
        var _c = global.card_data[i];

        if (!is_undefined(_c) && _c.type == _type) 
		{
            // if a subtype was provided, check it too
            if (is_undefined(_subtype) || _c.subtype == _subtype) 
			{
                array_push(_result, i);
            }
        }
    }
    
    return _result;
}

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

function add_keyword_to_card(_id, _keyword) 
{
    var _card = global.card_data[_id];

    if (is_undefined(_card)) return; // safety check

    // only add if it doesn't already exist
    if (!array_contains(_card.keywords, _keyword)) 
	{
        array_push(_card.keywords, _keyword);
    }
}

function setup_card(_card, _id) 
{
    var _data = global.card_data[_id];

    _card.card_id = _id;
    _card.card_type = _data.type;
    _card.sprite_index = _data.sprite;

    if (_data.type == CardType.Unit) _card.unit_object = _data.unit_object;
    else if (_data.type == CardType.Spell) _card.effect = _data.effect;
	
	show_debug_message($"Created: {_data.name}");
}