extends Area2D
class_name DeathArea

var player: Player

func _on_body_entered(body: Node2D) -> void:
	player = body
	player.death()
