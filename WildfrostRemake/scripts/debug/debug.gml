/// @func Returns the name of the card/unit
function get_name(_id)
{
	return global.card_data[_id.card_id].name;
}

/// @func Returns the name of the current phase
function get_phase(_phase)
{
	switch (_phase)
	{
		case Phase.Deployment: return "Deployment";
		case Phase.Casting: return "Casting";
		case Phase.Combat: return "Combat";
	}
}

function get_team(_team)
{
	return _team == Team.Player ? "player" : "enemy";
}

/// scr_console_register(name, fn)
/// @param name string
/// @param fn   function(args[], line)
function scr_console_register(name, fn) {
    with (oConsoleManager) {
        ds_map_replace(console.commands, string_lower(name), fn);
    }
}

/// scr_console_print(text)
function scr_console_print(text) {
    with (oConsoleManager) {
        array_push(console.log, string(text));
    }
}

/// scr_console_tokenize(line) -> array of tokens (supports "quoted strings")
function scr_console_tokenize(line) {
    var s = string(line);
    var out = [];
    var i = 1, n = string_length(s);
    while (i <= n) {
        // skip spaces
        while (i <= n && string_char_at(s, i) == " ") i++;
        if (i > n) break;

        var ch = string_char_at(s, i);
        if (ch == "\"") {
            // quoted
            i++;
            var start = i;
            while (i <= n && string_char_at(s, i) != "\"") i++;
            var tok = string_copy(s, start, i - start);
            array_push(out, tok);
            i++; // skip closing quote
        } else {
            var start2 = i;
            while (i <= n && string_char_at(s, i) != " ") i++;
            array_push(out, string_copy(s, start2, i - start2));
        }
    }
    return out;
}

/// scr_console_execute(line)
function scr_console_execute(line) {
    with (oConsoleManager) {
        scr_console_print("> " + line);

        var toks = scr_console_tokenize(line);
        if (array_length(toks) == 0) return;

        var cmd = string_lower(toks[0]);
        var args = array_create(max(0, array_length(toks) - 1));
        for (var i = 1; i < array_length(toks); i++) args[i-1] = toks[i];

        if (ds_map_exists(console.commands, cmd)) {
            var fn = console.commands[? cmd];
            // call user function
            fn(args, line);
        } else {
            scr_console_print("unknown command: " + cmd + " (try: help)");
        }
    }
}