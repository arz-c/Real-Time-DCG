extends Node2D
class_name Deck

const _CARD_SCENE = preload("res://src/scenes/Card.tscn")
const _CARD_GAP = 1

var cards: = []
var _total_cards: int

func _init(pos: Vector2, total_cards: int, angle: int) -> void:
	set_position(pos)
	rotate(deg2rad(angle))
	_total_cards = total_cards

func _ready() -> void:
	for i in range(_total_cards):
		var card: = _CARD_SCENE.instance()
		var pos: = Vector2(0, i * _CARD_GAP)
		card.set_position(pos)
		card.set_scale(Vector2(Global.CARD_SCALE, Global.CARD_SCALE))
		add_child(card)
		cards.append(card)

func get_top_card() -> Card:
	var card = cards.pop_back()
	return card
