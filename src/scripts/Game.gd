extends Node2D

var deck1: Deck
var deck2: Deck
var hand1: Hand

func _ready() -> void:
	# Decks
	deck1 = Deck.new(Vector2(100, 100), 30)
	add_child(deck1)
	deck2 = Deck.new(Vector2(100, 410), 30)
	add_child(deck2)
	
	# Hands
	hand1 = Hand.new(Vector2(500, 400), Vector2(-1, 0))
	add_child(hand1)
	hand1.take_from_deck(deck1, 5)
