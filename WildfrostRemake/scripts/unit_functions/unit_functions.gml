function create_unit(_hp, _atk, _time, _spr, _owner, _type) 
{
    return {
        hp: _hp,
        attack: _atk,
        time: _time,
        sprite: _spr,
        owner: _owner,        // "player" or "enemy"
        type: _type,          // commander, mercenary, summon

        // helper functions
        take_damage: function(_amount) 
		{
            self.hp -= _amount;
            if (self.hp <= 0) 
			{
                // handle death here
            }
        },

        attack_target: function(_target) 
		{
            if (is_undefined(_target)) return;
            _target.take_damage(self.attack);
        }
    };
}

function spawn_unit(_card_id, _grid_x, _grid_y, _owner) {
    var data = global.card_data[_card_id];

    var obj;
    switch (data.subtype) {
        case UnitType.Commander: obj = oUnitCommander; break;
        case UnitType.Mercenary: obj = oUnitMercenary; break;
        case UnitType.Summon:    obj = oUnitSummon;    break;
        default: obj = oUnitMercenary;
    }

    // create the instance
    var inst = instance_create_layer(_grid_x, _grid_y, "Units", obj);

    // store the card_id inside the instance for reference
    inst.card_id = _card_id;

    // assign stats
    inst.stats = create_unit(
        data.hp,
        data.attack,
        data.time,
        data.sprite,
        _owner,
        data.subtype
    );
	
	// set the instance sprite to match the card data
	inst.sprite_index = data.sprite;

    return inst;
}