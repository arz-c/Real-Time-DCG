extends Node2D

export(StreamTexture) var image = null
export var title = "Name"
export var description = "This card kills all units, and revives both faces"
export var hp = 2
export var mv_spd = 3
export var atk_spd = 1
export var atk = 5

func _ready():
	$Image.set_texture(image)
	$Title.set_text(title)
	$Description.set_text(description)
	$HP.set_text(String(hp))
	$MvSpd.set_text(String(mv_spd))
	$AtkSpd.set_text(String(atk_spd))
	$Atk.set_text(String(atk))
