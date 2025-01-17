extends Node2D

@onready var damage_area: Area2D = $DamageArea


func _init(damage: int):
	damage_area.damage = damage
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
