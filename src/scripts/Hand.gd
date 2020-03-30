extends Node2D
class_name Hand

const _CARD_VISIBLE_AREA = 100
const _CARD_MOVE_SPEED = 1000

var cards: = []
var _anim_card: = null
var angle: = 0

func _init(pos: Vector2, angle_: int) -> void:
	set_position(pos)
	angle = angle_

func _add_card(card: Card) -> void:
	cards.append(card)
	card.rotate(deg2rad(angle))
	
	# Animations
	card.play_flip_anim(true)
	_anim_card = card
	
	# Calculations for new pos
	var card_width: float = card.get_width()
	var start_x: = get_position().x
	var half_w: = (float(card_width) + (_CARD_VISIBLE_AREA * (len(cards) - 1))) / 2
	start_x -= half_w
	
	# Assigning destinations to every card
	for card in cards:
		var parent_pos = card.get_parent().get_position()
		card.set_dest(Vector2(start_x + float(card_width) / 2 - parent_pos.x, get_position().y - parent_pos.y), _CARD_MOVE_SPEED)
		start_x += _CARD_VISIBLE_AREA
	set_process(true)

func take_from_deck(deck: Deck, num: int) -> void:
	for _i in range(num):
		var card: = deck.get_top_card()
		
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
