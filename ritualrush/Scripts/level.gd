extends Node2D
# Setting the class name for all levels so they can be called easier
class_name Level

# Public variables to be set in the editor. Could be used in level loading and unloading at a later point in the project
@export var levelNr: int
@export var levelVisible: bool

# Process that checks if it has to set value
func _process(_delta: float) -> void:
	if !levelVisible:
		self.visible = false
	else:	
		self.visible = true

# When it gets called then this Level gets set to invisible. Not implemented at the moment.
func setVisibility(value: bool):
	levelVisible = value
