draw_self();

if (global.dragged_obj != noone && global.dragged_obj.card_type != CardType.Spell)
{
	if (team == Team.Player) 
		if (!occupied) 
			draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_green, 1);
}

if (team == Team.Enemy && !occupied)
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_gray, 1);