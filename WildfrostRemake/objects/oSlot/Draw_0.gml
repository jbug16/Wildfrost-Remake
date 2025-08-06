draw_self();

if (global.dragged_obj != noone && global.dragged_obj.card_type != CardType.Spell)
{
	if (team == "player") 
		if (!occupied) 
			draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_green, 1);
}