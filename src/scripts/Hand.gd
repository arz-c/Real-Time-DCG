extends Node2D
class_name Hand

export var max_cards_hand = 10

var cards = []
const _CARD_OVERLAP_MARGIN = 40
const _CARD_MOVE_SPEED = 200
var _new_card_pos = []
var _anim_card = null
var _left_dir

func _init(pos: Vector2, left_dir: Vector2) -> void:
	self.set_position(pos)
	self._left_dir = left_dir

func _ready() -> void:
	print("[hand] ready, cards ", cards)
	print("[hand] ready, new ", _new_card_pos)
	set_process(true)

func _process(_delta: float) -> void:
	if _anim_card and not _anim_card.is_anim:
		for i in range(len(cards)):
			if (_new_card_pos[i] - cards[i].get_position()).length() <= 5:
				cards[i].set_vel(Vector2.ZERO)
			else:
				var temp = (_new_card_pos[i] - cards[i].get_position()).normalized() * _CARD_MOVE_SPEED
				cards[i].set_vel(temp)
	var temp2 = cards[0].get_node("CardBack")
	print("test")

func add_card(card: Card):
	card.play_flip_anim(true)
	cards.append(card)
	_anim_card = card
	#card.set_position(Vector2(300,300))
	add_child(card)
	var card_width = card.get_width()
	for i in range(len(cards)):
		if _left_dir.x != 0:
			_new_card_pos.append(Vector2(
				self.get_position().x + (_left_dir.x * (((card_width + _CARD_OVERLAP_MARGIN * (len(cards) - 1)) / 2)) + i * card_width),
				self.get_position().y
			))
		elif _left_dir.y != 0:
			_new_card_pos.append(Vector2(
				self.get_position().x,
				self.get_position().y + (_left_dir.x * (((card_width + _CARD_OVERLAP_MARGIN * (len(cards) - 1)) / 2)) + i * card_width)
			))
			

func stop_loop():
	set_process(false)
	_new_card_pos = []
