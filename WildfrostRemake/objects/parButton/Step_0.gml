// Check if mouse is over button and user not dragging card
hover = position_meeting(mouse_x, mouse_y, id) && enabled && global.dragged_obj == noone;

// Check if pressed on button
if (hover && enabled && mouse_check_button_pressed(mb_left)) 
{
    pressed = true;
}

// Trigger action on click
if (pressed && mouse_check_button_released(mb_left)) 
{
    // Fire only if we released while still on the button
    if (hover && enabled) event_user(0); // call action, child overrides this
    pressed = false;
}

// Cancel if mouse released elsewhere
if (!mouse_check_button(mb_left)) pressed = false;