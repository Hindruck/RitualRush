extends Area2D

@onready var teleport_location: Marker2D = $TeleportLocation


func _on_body_entered(body: Node2D) -> void:
	body.set_position(teleport_location.global_position)
	
