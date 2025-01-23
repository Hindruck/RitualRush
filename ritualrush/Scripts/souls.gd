extends Area2D


# Boolean to make sure the Soul only gets triggered once
var isTriggered = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# When player enters the signal gets emitted and play the pick up animation and makes sure it only triggers once
func _on_body_entered(_body: Node2D) -> void:
	if !isTriggered:
		SignalbusGlobal.soul_Collected.emit()
		animated_sprite.play("PickedUp")
		isTriggered = true	

# When the Pick up Animation is finished the Scene gets destroyed
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
