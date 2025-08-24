/// @function Defines an attack spell
function spell_attack()
{
	if (!instance_exists(spell_target)) return;
	
	var _data = global.card_data[card_id];
    var _amt  = _data.attack;
	
	spell_target.stats.hp -= _amt;
	
    f($"Attack! Dealt {_amt} to {_data.name}");
}

/// @function Defines a healing spell
function spell_heal()
{
	if (!instance_exists(spell_target)) return;
	
	var _data = global.card_data[card_id];
    var _amt  = _data.attack;
	
	spell_target.stats.hp += _amt;
	
    f($"Heal! Healed {_amt} to {_data.name}");
}