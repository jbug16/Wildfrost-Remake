/// @desc Draw cards
if (instance_exists(oConsoleManager) && oConsoleManager.console.open) exit;

draw_card(6, global.deck);