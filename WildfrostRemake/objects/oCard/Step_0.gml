#region Animation

card_hover_effect(1, 0.25); // default scale, lerp amount

#endregion

#region Movement

if (global.current_phase == Phase.Comabt) exit;
start_drag();
update_drag();
stop_drag();

#endregion