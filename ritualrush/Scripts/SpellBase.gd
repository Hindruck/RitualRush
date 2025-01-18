extends Node2D
class_name Spell

@onready var damage_area: Area2D = $DamageArea
@onready var timer: Timer = $Timer


func spawn(damage: int, direction: float):
	position.x = 150 * direction
	damage_area.damage = damage
	timer.start
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()
