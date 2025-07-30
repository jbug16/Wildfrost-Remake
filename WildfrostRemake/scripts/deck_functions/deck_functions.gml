function build_starting_hand()
{
	// Cpoy halo cards to starting hand
	var _halo = get_cards_by_keyword(Keyword.Halo);
	var _len = array_length(_halo);
	array_copy(global.starting_hand, 0, _halo, 0, _len);
	
	// Create cards
    for (var i = 0; i < _len; i++) 
	{
		var _id = global.starting_hand[i];
		
		// Create the card instance
        var _inst = instance_create_layer(100 + (i * 80), 500, "Cards", parCard);
        setup_card(_inst, _id);

        // Store card instance in current hand
        array_push(global.current_hand, _inst);
    }
	
	show_debug_message($"[build_starting_hand]: {global.current_hand}");
}

function build_deck()
{
	var _deck = [];
	var _num = 6;
	
	// Add random units
	var _units = get_cards_by_type(CardType.Unit, UnitType.Mercenary);
    for (var i = 0; i < _num; i++) 
	{
        var _id = _units[irandom(array_length(_units) - 1)];
        array_push(_deck, _id);
    }

    // Add random spells
    var _spells = get_cards_by_type(CardType.Spell);
    for (var i = 0; i < _num; i++) 
	{
        var _id = _spells[irandom(array_length(_spells) - 1)];
        array_push(_deck, _id);
    }
	
	show_debug_message($"[build_deck]: {_deck}");
	return _deck;
}

function clear_hand()
{
	for (var i = 0; i < array_length(global.current_hand); i++) 
	{
        if (instance_exists(global.current_hand[i])) 
		{
            instance_destroy(global.current_hand[i]);
        }
    }
    
	global.current_hand = [];
}

function draw_card(_amount, _deck)
{
	// No more cards to draw from
	if (array_length(_deck) == 0) return;
	
    clear_hand();

    // Draw x random cards
    for (var i = 0; i < _amount; i++) 
	{
        var _id = _deck[irandom(array_length(_deck) - 1)];

        // Create the card instance
        var _inst = instance_create_layer(100 + (i * 80), 500, "Cards", parCard);
        setup_card(_inst, _id);
		
		// Remove card from deck
		array_delete(deck, _id, 1);

        // Store card instance in current hand
        array_push(global.current_hand, _inst);
    }
	
	show_debug_message($"[draw_card]: {global.current_hand}");
}