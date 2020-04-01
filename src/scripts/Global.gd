extends Node

const _CARD_DATA_PATH = "res://src/card_data.json"

const UNSCALED_CARD_SIZE = Vector2(164, 208)
const CARD_SCALE = 0.5
onready var WINDOW_SIZE = get_viewport().get_size()
var CARDS_DATA: Array

func _ready() -> void:
	var file = File.new()
	file.open(_CARD_DATA_PATH, file.READ)
	CARDS_DATA = parse_json(file.get_as_text())
	file.close()
