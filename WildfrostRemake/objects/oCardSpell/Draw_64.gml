if (dragging) 
{
    var start_x = x;
    var start_y = y;

    var end_x = mouse_x;
    var end_y = mouse_y;

    if (spell_target != noone) 
	{
        end_x = spell_target.x;
        end_y = spell_target.y;
    }

    draw_line_width(start_x, start_y, end_x, end_y, 6);

    // Draw arrowhead
    var ang = point_direction(start_x, start_y, end_x, end_y);
    var head_len = 24;
	var offset = 40;

    var x1 = end_x - lengthdir_x(head_len, ang + offset);
    var y1 = end_y - lengthdir_y(head_len, ang + offset);

    var x2 = end_x - lengthdir_x(head_len, ang - offset);
    var y2 = end_y - lengthdir_y(head_len, ang - offset);

    draw_triangle(end_x, end_y, x1, y1, x2, y2, false);
}