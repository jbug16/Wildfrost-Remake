#region Animation

card_hover_effect(1, 0.25); // default scale, lerp amount

#endregion

#region Movement

if (global.current_phase == Phase.Combat) exit;
if (!can_drag) exit;
start_drag();
update_drag();
stop_drag(); // play card

#endregion