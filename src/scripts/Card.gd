extends Node2D
class_name Card

const _FLIP_SPEED = 0.05
const _ENLARGE_SPEED = 1500

signal movement_anim_finished
var pre_enlarged_pos = null
var in_hand = false
var _vel: = Vector2.ZERO
var _override_delta: = false
var _max_scale: = 0.5
var _flipping_state = 0 # 0 = nothing, 1 = decreasing, 2 = increasing
var _flip_to_front: = true
var _dest = null

func _ready() -> void:
	_max_scale = get_scale().x
	# warning-ignore:return_value_discarded
	connect("movement_anim_finished", self, "on_movement_anim_finished")
	var data = Global.CARDS_DATA[0]
	$CardFront/Image.set_texture(load(data["info"]["image"]))
	$CardFront/Title.set_text(data["info"]["name"])
	$CardFront/Description.set_text(data["info"]["desc"])
	$CardFront/HP.set_text(String(data["stats"]["hp"]))
	$CardFront/MvSpd.set_text(String(data["stats"]["mv_spd"]))
	$CardFront/AtkSpd.set_text(String(data["stats"]["atk_spd"]))
	$CardFront/Atk.set_text(String(data["stats"]["atk"]))
	set_process(false)
	
func _process(delta: float) -> void:
	translate(_vel if _override_delta else _vel * delta)
	flip_anim()
	if _dest != null:
		move_to_dest(delta)

func flip_anim() -> void:
	match _flipping_state:
		1:
			set_scale(get_scale() - Vector2(_FLIP_SPEED, 0))
			if get_scale().x <= 0:
				_flipping_state = 2
				if _flip_to_front:
					$CardFront.set_visible(true)
					$CardBack.set_visible(false)
				else:
					$CardFront.set_visible(false)
					$CardBack.set_visible(true)
		2:
			set_scale(get_scale() + Vector2(_FLIP_SPEED, 0))
			if get_scale().x >= _max_scale:
				_flipping_state = 0
	
func move_to_dest(delta) -> void:
	if pre_enlarged_pos != null:
		set_z_index(2)
	if abs(_dest.x - get_global_position().x) < abs(_vel.x * delta) or abs(_dest.y - get_global_position().y) < abs(_vel.y * delta):
		# Reducing vel to compensate for overshoot 
		_vel = _dest - get_global_position()
		_override_delta = true
	elif get_global_position().distance_to(_dest) == 0:
		# Movement finished
		_vel = Vector2.ZERO
		emit_signal("movement_anim_finished")
		_override_delta = false

func on_movement_anim_finished() -> void:
	if get_scale() == Vector2(_max_scale, _max_scale):
		set_process(false)

func set_dest(dest_: Vector2, speed: float) -> void:
	_vel = (dest_ - get_global_position()).normalized() * speed
	_dest = dest_
	set_process(true)

func get_width() -> float:
	return $CardFront/Frame.get_rect().size.x

func play_flip_anim(to_front: bool) -> void:
	_flip_to_front = to_front
	_flipping_state = 1
	set_process(true)

func enlarge() -> void:
	pre_enlarged_pos = get_global_position()
	$AnimationPlayer.play("enlarge")
	set_dest(Global.WINDOW_SIZE / 2, _ENLARGE_SPEED)

func smallen() -> void:
	set_z_index(0)
	$AnimationPlayer.play("smallen")
	set_dest(pre_enlarged_pos, _ENLARGE_SPEED)
	pre_enlarged_pos = null
