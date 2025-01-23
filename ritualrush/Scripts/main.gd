extends Node2D

# Count of all of the Souls that are collected
var soulsCount := 0

# References to the player and the two Soul Labels
@onready var player: Player = $Player
@onready var souls_counter: Label = $Player/Camera2D/SoulsCounter
@onready var final_soul_count: Label = $"Levels/Final Screen/FinalSoulCount"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalbusGlobal.soul_Collected.connect(onSoulCollected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Gets signaled by every Souls when it is collected
func onSoulCollected() -> void:
	# Adds to the Count
	soulsCount += 1
	# Displays in moving counter and final room text get updated
	souls_counter.text = str(soulsCount)
	final_soul_count.text = str(soulsCount)
