extends Node2D

var deck1: Deck
var deck2: Deck

var hand1: Hand

var _card_template: = preload("res://src/scenes/Card.tscn")

func _ready() -> void:
	deck1 = Deck.new(Vector2(100, 100), 30)
	deck2 = Deck.new(Vector2(100, 410), 30)
	add_child(deck1)
	add_child(deck2)
	
	hand1 = Hand.new(Vector2(200, 200), Vector2(-1, 0))
	#add_child(hand1)
	
	#var card: = _card_template.instance()
	
	var popped_card = deck1.get_top_card(hand1)
	#print("[game] popped card, ", popped_card)
	hand1.add_card(popped_card)
	#hand1.add_card(card)
	add_child(hand1)
