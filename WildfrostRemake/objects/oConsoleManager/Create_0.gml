console = {
    open: false,
    input: "",
    caret_timer: 0,
    history: [],          // array of past lines
    history_pos: -1,      // -1 = live input
    log: [],              // output lines
    commands: ds_map_create() // name -> function(args, line)
};

// Style
font_console = fntDefault;
row_h = 18;
max_log_lines = 12;

// Basic commands
scr_console_register("help", function(args, line) {
    var keys = ds_map_keys_to_array(console.commands);
    array_sort(keys, true);
    for (var i = 0; i < array_length(keys); i++) scr_console_print(keys[i]);
});
scr_console_register("clear", function(args, line) { console.log = []; });

// Game commands
scr_console_register("devmode", function(args, line) {
	if (array_length(args) == 0)
	{
		scr_console_print("ERROR: Usage: devmode <on|off>");
        return;
	}
	
    var arg = string_lower(args[0]);
    if (arg == "on") 
	{
        global.dev_mode = true;
    } 
	else if (arg == "off") 
	{
        global.dev_mode = false;
    } 
	else 
	{
        scr_console_print("ERROR: Usage: devmode <on|off>");
        return;
    }

    scr_console_print($"Developer mode: {global.dev_mode ? "ON" : "OFF"}");
});

scr_console_register("drawcards", function(args, line) {
	draw_card(6, global.deck);
});

scr_console_register("skipwave", function(args, line) {
	with (oCard) if (team == Team.Enemy) instance_destroy();
    if (instance_exists(oWaveManager)) with (oWaveManager) start_next_wave();
    scr_console_print("skipped to next wave");
});

scr_console_register("killallenemies", function(args, line) {
    with (oCard) if (team == Team.Enemy) kill_unit(id);
    scr_console_print("all enemies killed");
});

scr_console_register("endturn", function(args, line) {
	if (global.current_phase == Phase.Deployment) scr_console_print("ERROR: deploy commander first");
    else 
	{
		end_turn();
		scr_console_print("turn ended");
	}
});

scr_console_register("kill", function(args, line) {
    // usage check
    if (array_length(args) < 2) {
        scr_console_print("ERROR: Usage: kill <team(player|enemy|p|e)> <slot>");
        return false;
    }

    // parse team
    var t = string_lower(string(args[0]));
    var team;
    switch (t) {
        case "p": case "pl": case "player": team = Team.Player; break;
        case "e": case "en": case "enemy":  team = Team.Enemy;  break;
        default:
            scr_console_print("ERROR: Unknown team: " + args[0]);
            return false;
    }

    // parse slot
    var s_raw = real(args[1]);
    if (!is_real(s_raw)) {
        scr_console_print("ERROR: Slot must be a number");
        return false;
    }

    var slot = s_raw;
    if (slot >= 1) slot -= 1;

    // locate and kill unit
    if (is_array(global.current_grid) && is_array(global.current_grid[team])) {
        var slots = global.current_grid[team];
        if (slot < 0 || slot >= array_length(slots)) {
            scr_console_print("ERROR: Slot out of range for team");
            return false;
        }

        var u = slots[slot];
        if (instance_exists(u)) 
		{
            with (u) kill_unit(u);
			scr_console_print($"Killed {get_team(team)} unit in slot {slot+1}");
            return true;
        } 
		else 
		{
			scr_console_print($"ERROR: No {get_team(team)} unit in slot {slot+1}");
            return false;
        }
    }

    return false;
});