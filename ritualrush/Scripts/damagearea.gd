extends Area2D
class_name DamageArea

@export var damage: int = 10
var player: Player

func _on_body_entered(body: Node2D) -> void:
	player = body
	player.takeDamage(damage)
