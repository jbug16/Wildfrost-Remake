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

function spawn_unit(_card, _grid_x, _grid_y, _owner) 
{
    var inst = instance_create_layer(_grid_x, _grid_y, "Units", global.card_data[_card.card_id].unit_object);
    inst.card_id = _card.card_id;

    // Make a copy of the stats
    inst.stats = create_unit(
        _card.stats.hp,
        _card.stats.attack,
        _card.stats.time,
        _card.stats.sprite,
        _owner,
        _card.stats.type
    );

    inst.sprite_index = inst.stats.sprite;
    return inst;
}