#region Animation

card_hover_effect(1, 0.25); // (default scale, lerp amount)

#endregion

#region Movement

if (global.current_phase == Phase.Combat) exit; // player can't move cards during combat
if (!can_drag) exit; // player can't drag card if can_drag is false

// Actions that happen when trying to drag card
start_drag();
update_drag();
stop_drag(); // play card

#endregion