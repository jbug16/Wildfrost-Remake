function build_starting_hand()
{
	var _halo = get_cards_by_keyword(Keyword.Halo); // array of cards with halo
	var _len = array_length(_halo);
	
	// Create cards
    for (var i = 0; i < _len; i++) 
	{
		var _id = _halo[i];
		
		// Create the card instance
        var _inst = spawn_hand(_id);

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
		var _index = irandom(array_length(_deck) - 1);
        var _id = _deck[_index];

        // Create the card instance
        var _inst = spawn_hand(_id);
		
		// Remove card from deck
		array_delete(_deck, _index, 1);

        // Store card instance in current hand
        array_push(global.current_hand, _inst);
    }
	
	reposition_cards();
	show_debug_message($"[draw_card]: {global.current_hand}");
}

function spawn_hand(_id) 
{
    var _data = global.card_data[_id];
    var _obj;

    // Decide which object to spawn
    if (_data.type == CardType.Unit) _obj = oCardUnit;
    else if (_data.type == CardType.Spell) _obj = oCardSpell;
    else _obj = parCard;

    // create instance of the correct object
    var _inst = instance_create_layer(oHandManager.x, oHandManager.y, "Cards", _obj);
	array_push(global.current_grid, _inst);
    setup_card(_inst, _id);

    return _inst;
}

function reposition_cards() 
{
    var count = array_length(global.current_hand);
    if (count == 0) return;

    // get manager width
    var hand_width = sprite_get_width(oHandManager.sprite_index);

    // default spacing
    var spacing = HAND_SPACING;

    // shrink spacing if cards don't fit
    if ((count - 1) * spacing > hand_width) {
        spacing = hand_width / (count - 1);
    }

    // total width of all cards
    var total_width = (count - 1) * spacing;

    // center group inside manager
    var start_x = oHandManager.x - (total_width / 2);

    for (var i = 0; i < count; i++) {
        var card = global.current_hand[i];

        if (instance_exists(card)) {
            var target_x = start_x + (i * spacing);
            var target_y = oHandManager.y;

            card.x = target_x;
            card.y = target_y;
        }
    }
}