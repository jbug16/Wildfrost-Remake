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