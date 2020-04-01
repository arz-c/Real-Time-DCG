extends Area2D

func _input_event(_viewport: Object, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("ui_right_click") and get_parent().in_hand:
		get_parent().get_parent().clicked.append(get_parent())
		get_parent().get_parent().set_process(true)
