extends Node2D
class_name Deck

const _CARD_GAP = 1

var cards: = []
var _total_cards: int
var _card_template: = preload("res://src/scenes/Card.tscn")

func _init(pos: Vector2, total_cards: int) -> void:
	set_position(pos)
	_total_cards = total_cards

func _ready() -> void:
	print("deck ready")
	for i in range(_total_cards):
		var card: = _card_template.instance()
		var pos: = self.get_position()
		pos.y += i * _CARD_GAP
		card.set_position(pos)
		add_child(card)
		cards.append(card)

func get_top_card() -> Card:
	var out = cards.pop_back()
	print("[deck] popped card, ", out)
	return out
