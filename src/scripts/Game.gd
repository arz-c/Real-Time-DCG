extends Node2D

var deck1: Deck
var deck2: Deck
var hand1: Hand
var hand2: Hand

func _ready() -> void:
	# Decks
	deck1 = Deck.new(Vector2(1575, 150), 30, 180)
	add_child(deck1)
	
	deck2 = Deck.new(Vector2(100, 810), 30, 0)
	add_child(deck2)
	
	# Hands
	hand1 = Hand.new(Vector2(800, 150), 180)
	add_child(hand1)
	hand1.take_from_deck(deck1, 5)
	
	hand2 = Hand.new(Vector2(800, 810), 0)
	add_child(hand2)
	hand2.take_from_deck(deck2, 5)
