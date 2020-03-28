extends Node2D
class_name Hand

const _CARD_OVERLAP_MARGIN = 50
const _CARD_MOVE_SPEED = 200

var cards = []
var _new_card_pos = []
var _anim_card = null
var _left_dir



func _init(pos: Vector2, left_dir: Vector2) -> void:
	self.set_position(pos)
	self._left_dir = left_dir

func _process(_delta: float) -> void:
	for i in range(len(cards)):
		if (_new_card_pos[i] - cards[i].get_position()).length() <= 5:
			cards[i].set_vel(Vector2.ZERO)
			cards[i].emit_movement_anim_finished_signal()
		else:
			cards[i].set_vel((_new_card_pos[i] - cards[i].get_position()).normalized() * _CARD_MOVE_SPEED)
		print(cards[i].get_position())

func _add_card(card: Card):
	card.play_flip_anim(true)
	cards.append(card)
	#card.get_parent().remove_child(card)
	add_child(card)
	_anim_card = card
	var card_width = card.get_width()
	for i in range(len(cards)):
		if len(_new_card_pos) < len(cards):
			_new_card_pos.append(null)
		if _left_dir.x != 0:
			_new_card_pos[i] = Vector2(
				get_position().x + ((_left_dir.x * ((card_width + _CARD_OVERLAP_MARGIN * (len(cards) - 1)) / 2)) + ((_left_dir.x * -1) * i * card_width)),
				get_position().y
			)
			#_new_card_pos[i] = Vector2(
			#	get_position().x - ((card_width + _CARD_OVERLAP_MARGIN * (len(cards) - 1)) / 2) + i * card_width,
			#	get_position().y
			#)
		elif _left_dir.y != 0:
			_new_card_pos[i] = Vector2(
				get_position().x,
				get_position().y + ((_left_dir.x * ((card_width + _CARD_OVERLAP_MARGIN * (len(cards) - 1)) / 2)) + ((_left_dir.x * -1) * i * card_width))
			)
	set_process(true)

func take_from_deck(deck: Deck, num: int):
	for i in range(num):
		var card = deck.get_top_card()
		_add_card(card)
		yield(card, "movement_anim_finished")

func stop_loop():
	set_process(false)
	_new_card_pos = []
	
#w = card width
#g = gap
#x, y = center
#total_dist = w + g * (n - 1)
#center = total_dist / 2
#
#
#first_card.x = x - (w + g * (n - 1) / 2)
#first_card.y = y - (w + g * (n - 1) / 2)
#
#second_card.x = (x - (w + g * (n - 1) / 2)) + w
#second_card.y = (y - (w + g * (n - 1) / 2)) + w
#
#n_card.x = x - ((w + g * (n - 1)) / 2) + i * w
