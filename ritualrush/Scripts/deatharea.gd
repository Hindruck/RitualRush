extends Area2D
# Setting the class name to be able to create References
class_name DeathArea

# Declaring a player variable
var player: Player

# When the player enters they instanty die
func _on_body_entered(body: Node2D) -> void:
	player = body
	player.death()
