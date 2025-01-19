extends Node2D

var currentLevel :int = 1
@onready var player: Player = $Player

@onready var level_1: Level = $Levels/Level1
@onready var level_2: Level = $Levels/Level2


var levelList: Dictionary = {
	1: "Level1",
	2: "Level2",
	}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
