total_waves = 3;
wave_enemies = [
    [], // empty, unused
    [ 
		// Wave 1
		// 2 Enemies
		{card_id: CardID.ME_Foxee, row: 0, col: 0}, 
		{card_id: CardID.ME_Foxee, row: 1, col: 0} 
	],
    [ 
		// Wave 2
		// 3 Enemies
		{card_id: CardID.ME_Foxee, row: 0, col: 0}, 
		{card_id: CardID.ME_Foxee, row: 1, col: 0}, 
		{card_id: CardID.ME_Foxee, row: 0, col: 1} 
	],
    [ 
		// Wave 3
		// 2 Enemies + Boss
		{card_id: CardID.CO_Toppit, row: 0, col: 0},
		{card_id: CardID.ME_Foxee, row: 1, col: 0}, 
		{card_id: CardID.ME_Foxee, row: 0, col: 1},
	]
];