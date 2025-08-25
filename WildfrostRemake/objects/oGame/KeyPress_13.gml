/// @desc Move all units forward
for (var i = 0; i < 6; i++) 
{
    var u = global.current_grid[Team.Player][i];
    if (instance_exists(u)) 
	{
		advance_unit_toward_front(u);
	}
}