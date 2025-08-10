if (!visible_btn) exit;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// hover check (gui space)
hover = (mx >= x && mx <= x + w && my >= y && my <= y + h) && enabled;

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
