hover = position_meeting(mouse_x, mouse_y, id) && enabled && global.dragged_obj == noone;

if (hover && enabled && mouse_check_button_pressed(mb_left)) 
{
    pressed = true;
}

if (pressed && mouse_check_button_released(mb_left)) 
{
    // fire only if we released while still on the button
    if (hover && enabled) event_user(0); // child overrides this
    pressed = false;
}

// cancel if mouse released elsewhere
if (!mouse_check_button(mb_left)) pressed = false;