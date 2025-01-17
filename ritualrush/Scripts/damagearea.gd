extends Area2D

@export var damage: int = 10

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.5
	var player: CharacterBody2D = body
	player.takeDamage(damage)
