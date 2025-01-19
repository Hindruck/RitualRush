extends Node2D

var soulsCount := 0
@onready var player: Player = $Player
@onready var souls_counter: Label = $Player/Camera2D/SoulsCounter
@onready var final_soul_count: Label = $"Levels/Final Screen/FinalSoulCount"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_souls_soul_collected() -> void:
	soulsCount += 1
	souls_counter.text = str(soulsCount)
	final_soul_count.text = str(soulsCount)
