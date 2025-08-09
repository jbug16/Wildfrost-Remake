/// @func Returns the name of the card/unit
function get_name(_id)
{
	return global.card_data[_id.card_id].name;
}

/// @func Returns the name of the current phase
function get_phase(_phase)
{
	switch (_phase)
	{
		case Phase.Deployment: return "Deployment";
		case Phase.Casting: return "Casting";
		case Phase.Comabt: return "Combat";
	}
}