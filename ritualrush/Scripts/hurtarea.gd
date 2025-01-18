extends Area2D
class_name HurtArea

@onready var hurt_collision: CollisionShape2D = $HurtCollision


func _on_area_entered(hitbox: AttackArea) -> void:
	if hitbox == null:
		return
	elif owner.has_method("takeDamage"):
		owner.takeDamage(hitbox.damage)
