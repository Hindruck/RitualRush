extends Area2D

# Loading in the Marker reference
@onready var teleport_location: Marker2D = $TeleportLocation

# Teleports the player to the teleport location when entering the attached collision
func _on_body_entered(body: Node2D) -> void:
	body.set_position(teleport_location.global_position)
	
