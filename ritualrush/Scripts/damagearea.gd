extends Area2D
# Setting the class name to be able to create References
class_name DamageArea
# Public variable to define the damage of the instances in the level
@export var damage: int = 10
# Declaring a player variable
var player: Player

# Player takes damage when entering and HP gets automatically reduced 
func _on_body_entered(body: Node2D) -> void:
	player = body
	player.takeDamage(damage)
