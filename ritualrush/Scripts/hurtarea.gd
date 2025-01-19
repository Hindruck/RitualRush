extends Area2D
class_name HurtArea

@onready var hurt_collision: CollisionShape2D = $HurtCollision

# When the area is entered then it automatically calls the takeDamage in the owner of the overlapping area
# Currently not listening for overlap
# Gets checked in the Scenes that implement the AttackAreas
func _on_area_entered(hitbox: AttackArea) -> void:
	if hitbox == null:
		return
	elif owner.has_method("takeDamage"):
		owner.takeDamage(hitbox.damage)
