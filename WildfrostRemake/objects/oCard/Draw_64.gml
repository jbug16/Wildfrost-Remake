// Debug
if (global.dev_mode)
{
	draw_set_settings(fa_center, fa_middle, c_white);
	draw_text(x, y-80, $"Row {row} -- Col {col}");
	if (hovered) 
	{
		var _target = find_attack_target(id);
	
		if (instance_exists(_target))
		{
			draw_set_color(c_red);
			draw_arrow(x, y, _target.x, _target.y, 16);
		}
	}
}

if (!dragging) exit;

// Draw card sprite
draw_sprite_ext(sprite_index, 0, x, y, current_scale, current_scale, 0, c_white, 1);

// Draw stats
draw_set_settings(fa_center, fa_middle);
draw_stats();

// Draw spell arrow
draw_spell_arrow();