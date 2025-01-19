extends Node2D
class_name Spell

var isCasting = false

@onready var hit_timer: Timer = $HitTimer
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var attack_area: AttackArea = $AttackArea



func spawn(direction: float):
	if !isCasting:
		isCasting = true
		self.visible = true
		animated_sprite.play("default")
		if direction > 0:
			position.x = 200
		elif direction < 0:
			position.x = -200	
		timer.start()	
		hit_timer.start()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.stop()


func _on_timer_timeout() -> void:
	self.visible = false
	isCasting = false


func _on_hit_timer_timeout() -> void:
	var hit_enemies = attack_area.get_overlapping_areas()
	
	for area in hit_enemies:
		var parent = area.get_parent()
		parent.takeDamage(attack_area.damage)
