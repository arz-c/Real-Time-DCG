extends Node2D
class_name Hand

const _CARD_VISIBLE_AREA = 100
const _CARD_MOVE_SPEED = 1000

var cards: = []
var _new_card_pos: = []
var _anim_card: = null
var angle: = 0

func _init(pos: Vector2, angle_: int) -> void:
	set_position(pos)
	angle = angle_

func _process(delta: float) -> void:
	for i in range(len(cards)):
		var card = cards[i]
		var new_pos = _new_card_pos[i]
		
		# Checking for overshoot
		if abs(new_pos.x - card.get_position().x) < abs(card.get_vel().x * delta) or abs(new_pos.y - card.get_position().y) < abs(card.get_vel().y * delta):
			# Reducing vel to compensate for overshoot 
			card.set_vel(new_pos - card.get_position())
			card.set_override_delta(true)
		elif card.get_position().distance_to(new_pos) == 0:
			# Movement finished
			card.set_vel(Vector2.ZERO)
			card.emit_movement_anim_finished_signal()
			card.set_override_delta(false)

func _add_card(card: Card):
	cards.append(card)
	card.rotate(deg2rad(angle))
	
	# Animations
	card.play_flip_anim(true)
	_anim_card = card
	
	# Calculations for new pos
	var card_width: int = card.get_width()
	var start_x: = get_position().x
	var half_w: = (float(card_width) + (_CARD_VISIBLE_AREA * (len(cards) - 1))) / 2
	start_x -= half_w
	
	# Placeholders put in array to be updated by index
	if len(_new_card_pos) < len(cards):
		_new_card_pos.append(null)
		
	# Assigning new pos and vel to every card
	for i in range(len(cards)):
		var parent_pos = cards[i].get_parent().get_position()
		_new_card_pos[i] = Vector2(start_x + float(card_width) / 2 - parent_pos.x, get_position().y - parent_pos.y)
		start_x += _CARD_VISIBLE_AREA
		cards[i].set_vel((_new_card_pos[i] - cards[i].get_position()).normalized() * _CARD_MOVE_SPEED)
	set_process(true)

func take_from_deck(deck: Deck, num: int):
	print("deck ", deck.get_position())
	for _i in range(num):
		var card: = deck.get_top_card()
		print(card.get_position())
		
		# Making coords relative to hand
		card.set_position(card.get_position() + card.get_parent().get_position() - get_position())
		
		# Reparenting from deck to hand
		card.get_parent().remove_child(card)
		add_child(card)
		
		_add_card(card)
		yield(card, "movement_anim_finished")
	set_process(false)
	
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
