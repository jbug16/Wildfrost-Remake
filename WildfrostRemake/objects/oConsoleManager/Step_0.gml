// Toggle with tab
if (keyboard_check_pressed(vk_tab)) {
    console.open = !console.open;
    if (console.open) {
        keyboard_string = ""; // fresh start
        console.input = "";
        console.history_pos = -1;
    }
}

// While open, eat input
if (console.open) {
    // Basic text input
    if (keyboard_string != "") {
        console.input += keyboard_string;
        keyboard_string = "";
    }

    // Delete with backspace
    if (keyboard_check_pressed(vk_backspace)) {
	    if (string_length(console.input) > 0) {
	        console.input = string_delete(console.input, string_length(console.input), 1);
	    }
	}

    // Submit
    if (keyboard_check_pressed(vk_enter)) {
        var line = string_trim(console.input);
        if (line != "") {
            array_push(console.history, line);
            scr_console_execute(line);
        }
        console.input = "";
        console.history_pos = -1;
    }

    // History nav (up and down arrows)
    if (keyboard_check_pressed(vk_up)) {
        if (array_length(console.history) > 0) {
            if (console.history_pos == -1) console.history_pos = array_length(console.history) - 1;
            else console.history_pos = clamp(console.history_pos - 1, 0, array_length(console.history) - 1);
            console.input = console.history[console.history_pos];
        }
    }
    if (keyboard_check_pressed(vk_down)) {
        if (console.history_pos != -1) {
            console.history_pos++;
            if (console.history_pos >= array_length(console.history)) {
                console.history_pos = -1;
                console.input = "";
            } else {
                console.input = console.history[console.history_pos];
            }
        }
    }

    // Caret blink
    console.caret_timer++;
}