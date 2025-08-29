init_card_data(); // creates all the card data
add_keyword_to_card(CardID.CO_Toppit, Keyword.Halo); // adds the "halo" keyword to Toppit
build_starting_hand(); // gives the player any cards marked with "halo" to start with

global.deck = build_deck(); // creates all cards in the deck