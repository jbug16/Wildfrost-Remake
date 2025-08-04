/// @func Sets all of the needed settings for drawing in one function
function draw_set_settings(_ha = fa_left, _va = fa_top, _col = c_white, _fnt = fntDefault)
{
	draw_set_halign(_ha);
	draw_set_valign(_va);
	draw_set_color(_col);
	draw_set_font(_fnt);
}

/// @func Draws the attack, HP and time stat onto the given card
function draw_stats(box_w = 20, box_h = 28, _offset = 4)
{
	// Attack box
	var atk_center_x = x - (sprite_width * 0.5 * current_scale) + ((_offset + box_w * 0.5) * current_scale);
	var atk_center_y = y - (sprite_height * 0.5 * current_scale) + ((_offset + box_h * 0.5) * current_scale);

	// HP box
	var blue_x = sprite_width - _offset - box_w;
	var hp_center_x = x - (sprite_width * 0.5 * current_scale) + ((blue_x + box_w * 0.5) * current_scale);
	var hp_center_y = atk_center_y;
	
	// Time box
	var time_center_x = x; // centered horizontally
	var time_center_y = y + (sprite_height * 0.5 * current_scale) - ((_offset + box_h * 0.5) * current_scale);

	// Center based on text height
	var text_h = string_height(string(stats.attack));
	atk_center_y -= text_h * 0.5 * current_scale;
	hp_center_y -= text_h * 0.5 * current_scale;
	time_center_y -= text_h * 0.5 * current_scale;

	// Attack
	if (has_stat(stats.attack))
	    draw_text_ext_transformed(atk_center_x, atk_center_y, string(stats.attack), 0, 100, current_scale, current_scale, 0);

	// HP
	if (has_stat(stats.hp))
		draw_text_ext_transformed(hp_center_x, hp_center_y, string(stats.hp), 0, 100, current_scale, current_scale, 0);

	// Time
	if (has_stat(stats.time))
		draw_text_ext_transformed(time_center_x, time_center_y, string(stats.time), 0, 100, current_scale, current_scale, 0);
}

/// @func Draws the arrow when using a spell card
function draw_spell_arrow()
{
	if (dragging && card_type == CardType.Spell) 
	{
	    draw_set_color(c_red);

	    var end_x = mouse_x;
	    var end_y = mouse_y;

	    if (instance_exists(spell_target)) 
	    {
	        end_x = spell_target.x;
	        end_y = spell_target.y;
	    }

	    draw_line_width(x, y, end_x, end_y, 3);
	}
}