extends Area2D


@onready var timer: Timer = $Timer
var player: Player

func _on_body_entered(body: Node2D) -> void:
	#Engine.time_scale = 0.5
	player = body
	player.death()
	#timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
