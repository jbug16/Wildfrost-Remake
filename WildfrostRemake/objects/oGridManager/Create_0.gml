// Defines row and col number per grid
grid_rows = 2;
grid_cols = 6;

slot_width  = sprite_get_width(sGridIcon);
slot_height = sprite_get_height(sGridIcon);

side_gap = 100;		// space between player & enemy grids
slot_gap_x = 20;	// horizontal spacing between slots
slot_gap_y = 10;	// vertical spacing between slots

// Total width = width of 3 slots + gaps between them, for both sides
var side_width = (3 * slot_width) + (2 * slot_gap_x);
var total_width = (side_width * 2) + side_gap;

// Total height = height of 2 slots + gap between rows
var total_height = (2 * slot_height) + slot_gap_y;

// Screen center
var screen_w = display_get_gui_width();
var screen_h = display_get_gui_height();

// Top-left starting point
grid_start_x = (screen_w * 0.5) - (total_width * 0.5);
grid_start_y = (screen_h * 0.5) - (total_height * 0.5) - 50;

grid_slots = array_create(grid_rows);

// Build slot positions
for (var r = 0; r < grid_rows; r++)
{
    grid_slots[r] = array_create(grid_cols);

    for (var c = 0; c < grid_cols; c++)
    {
        var side_index = (c >= 3) ? 1 : 0; // 0=player, 1=enemy
        var col_index  = (c % 3);

        // Offset for enemy side
        var side_offset = side_index * (side_width + side_gap);

        // Add spacing between columns and rows
        var x_pos = grid_start_x + side_offset + (col_index * (slot_width + slot_gap_x)) + slot_width * 0.5;
        var y_pos = grid_start_y + (r * (slot_height + slot_gap_y)) + slot_height * 0.5;

        grid_slots[r][c] = [x_pos, y_pos];
    }
}

// Create slot objects
for (var r = 0; r < grid_rows; r++)
{
    for (var c = 0; c < grid_cols; c++)
    {
        var pos = grid_slots[r][c]; // set position

        var slot_inst = instance_create_layer(pos[0], pos[1], "Grid", oSlot); // create obj

		// Set row and col number and team
        slot_inst.grid_row = r;
        slot_inst.grid_col = c;
        slot_inst.team = (c < 3) ? Team.Player : Team.Enemy;
    }
}