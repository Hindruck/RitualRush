extends Area2D

signal soul_Collected
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var isTriggered = false

func _on_body_entered(body: Node2D) -> void:
	if !isTriggered:
		soul_Collected.emit()
		animated_sprite.play("PickedUp")
		isTriggered = true	


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
