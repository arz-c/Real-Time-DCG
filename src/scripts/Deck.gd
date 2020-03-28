extends Node2D
class_name Deck

var total_cards: = 30
var cards: = []
 
const _CARD_GAP: = 1
var _card_template: = preload("res://src/scenes/Card.tscn")

func _init(pos: Vector2, total_cards_: int) -> void:
	set_position(pos)
	total_cards = total_cards_

func _ready() -> void:
	print("deck ready")
	for i in range(total_cards):
		var card: = _card_template.instance()
		var pos: = self.get_position()
		pos.y += i * _CARD_GAP
		card.set_position(pos)
		add_child(card)
		cards.append(card)

func get_top_card(new_parent) -> Card:
	var out = cards.pop_back()
	call_deferred("reparent", out, new_parent)
	print("[deck] popped card, ", out)
	return out

func reparent(node, parent):
	node.get_parent().remove_child(node)
	parent.add_child(node) 
