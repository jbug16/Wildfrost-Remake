/// @desc Draw cards
if (!global.dev_mode) exit;
if (instance_exists(oConsoleManager) && oConsoleManager.console.open) exit;

draw_card(6, global.deck);