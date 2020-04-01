extends Node2D
class_name Hand

const _CARD_MOVE_SPEED = 1000
var _CARD_VISIBLE_AREA: float = 100 

var cards: = []
var angle: = 0
var clicked = []

func _init(pos: Vector2, angle_: int) -> void:
	set_position(pos)
	angle = angle_

func _ready() -> void:
	set_process(false)

func _process(_delta: float) -> void:
	set_process(false)
	
	var topmost_clicked = clicked.front()
	for i in clicked:
		if i.get_index() > topmost_clicked.get_index():
			topmost_clicked = i
	clicked.clear()
	
	if topmost_clicked.pre_enlarged_pos == null:
		for card in cards:
			if card.pre_enlarged_pos != null:
				card.smallen()
		topmost_clicked.enlarge()
	else:
		topmost_clicked.smallen()

func _add_card(card: Card) -> void:
	cards.append(card)
	card.in_hand = true
	card.rotate(deg2rad(angle))
	
	# Animation
	card.play_flip_anim(true)
	
	# Calculations for new pos
	var card_width: float = float(card.get_width())
	var start_x: = get_global_position().x
	var half_w: float = (card_width + (_CARD_VISIBLE_AREA * (len(cards) - 1))) / 2
	start_x -= half_w
	
	_CARD_VISIBLE_AREA = (Global.CARD_SCALE / Global.UNSCALED_CARD_SIZE.x) * card_width * 200
	
	# Assigning destinations to every card
	for card in cards:
		card.set_dest(Vector2(start_x + float(card_width) / 2, get_global_position().y), _CARD_MOVE_SPEED)
		start_x += _CARD_VISIBLE_AREA

func take_from_deck(deck: Deck, num: int) -> void:
	for _i in range(num):
		# Taking card from top of deck
		var card: = deck.get_top_card()
		
		# Making coords relative to hand
		card.set_position(card.get_position() + card.get_parent().get_position() - get_position())
		
		# Reparenting from deck to hand
		card.get_parent().remove_child(card)
		add_child(card)
		
		_add_card(card)
		yield(card, "movement_anim_finished")
	set_process(false)
