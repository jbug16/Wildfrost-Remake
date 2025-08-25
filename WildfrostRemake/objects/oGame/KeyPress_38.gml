/// @desc Change phase
if (instance_exists(oConsoleManager) && oConsoleManager.console.open) exit;

global.current_phase++;
global.current_phase = global.current_phase > 2 ? 0 : global.current_phase;