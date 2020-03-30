extends Node2D
class_name Card

export(StreamTexture) var image: = preload("res://src/sprites/img.jpg")
export var title: = "Name"
export var description: = "This card kills all units, and revives both faces"
export var hp: = 2
export var mv_spd: = 3
export var atk_spd: = 1
export var atk: = 5

signal movement_anim_finished
var _vel: = Vector2.ZERO
var override_delta: = false

func _ready() -> void:
	_setup_card()
	set_process(true)

func _process(delta: float) -> void:
	translate(_vel if override_delta else _vel * delta)
	
func _setup_card() -> void:
	$CardFront/Image.set_texture(image)
	$CardFront/Title.set_text(title)
	$CardFront/Description.set_text(description)
	$CardFront/HP.set_text(String(hp))
	$CardFront/MvSpd.set_text(String(mv_spd))
	$CardFront/AtkSpd.set_text(String(atk_spd))
	$CardFront/Atk.set_text(String(atk))

func set_vel(vel: Vector2) -> void:
	_vel = vel

func get_vel() -> Vector2:
	return _vel

func set_override_delta(val: bool) -> void:
	override_delta = val

func emit_movement_anim_finished_signal() -> void:
	emit_signal("movement_anim_finished")

func get_width():
	return $CardFront/Frame.get_rect().size.x

func play_flip_anim(to_front: bool) -> void:
	if to_front:
		$AnimationPlayer.play("back_to_front")
	else:
		$AnimationPlayer.play("front_to_back")
