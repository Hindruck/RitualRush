extends Node2D
class_name Level

@export var levelNr: int
@export var levelVisible: bool

func _process(_delta: float) -> void:
	if !levelVisible:
		self.visible = false
	else:	
		self.visible = true

func setVisibility(value: bool):
	levelVisible = value
