/// @desc Print current hand
if (!global.dev_mode) exit;
if (instance_exists(oConsoleManager) && oConsoleManager.console.open) exit;

f(global.current_hand);