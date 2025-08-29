draw_self(); // draw sprite

// Check if user is dragging a valid card
if (global.dragged_obj != noone && global.dragged_obj.card_type != CardType.Spell)
{
	// Check what team the slot is on
	if (team == Team.Player) 
		// Check if there is a card already here
		if (!occupied) 
			// Color the slot green if slot is open
			draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_green, 1);
}

// Color any enemy slots or occupied slots gray
if (team == Team.Enemy && !occupied)
	draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_gray, 1);