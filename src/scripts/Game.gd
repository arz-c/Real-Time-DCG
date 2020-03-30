extends Node2D

const UI_MARGIN = 150

var deck1: Deck
var deck2: Deck
var hand1: Hand
var hand2: Hand

# TODO add left/right to hands

func _ready() -> void:
	var window_size = get_viewport().get_size()
	
	# Decks
	deck1 = Deck.new(Vector2(window_size.x - UI_MARGIN, UI_MARGIN), 30, 180)
	add_child(deck1)
	
	deck2 = Deck.new(Vector2(UI_MARGIN, window_size.y - UI_MARGIN), 30, 0)
	add_child(deck2)
	
	# Hands
	hand1 = Hand.new(Vector2(window_size.x / 2, UI_MARGIN), 180)
	add_child(hand1)
	hand1.take_from_deck(deck1, 5)
	
	hand2 = Hand.new(Vector2(window_size.x / 2, window_size.y - UI_MARGIN), 0)
	add_child(hand2)
	hand2.take_from_deck(deck2, 5)
