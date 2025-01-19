extends Node2D
# Base Class for Spells
class_name Spell

# General variable to check if the player is currently already casting
var isCasting = false

# Getting the needed variables and references to child nodes
@onready var hit_timer: Timer = $HitTimer
@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $AttackArea/CollisionShape2D
@onready var attack_area: AttackArea = $AttackArea


# Function to spawn the spell in
# Decided against velocity that it is at a constant range away from the player
func spawn(direction: float):
	if !isCasting:
		# Starts playing the animation when spawned and only is made visible when actively cast.
		isCasting = true
		self.visible = true
		animated_sprite.play("default")
		# Position is set depending on the player direction
		if direction > 0:
			position.x = 200
		elif direction < 0:
			position.x = -200	
		# Two timer start, general timer for the lifetime of the spell
		# Hit_Timer is shorter to match the animation with the damage
		timer.start()	
		hit_timer.start()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite.stop()


# Function to "Turn off" the Spell when it has reached the end of its lifetime
func _on_timer_timeout() -> void:
	self.visible = false
	isCasting = false

# Function that triggers when the animation shows the correct frame
func _on_hit_timer_timeout() -> void:
	# Get an array of all enemies caught withing the spell
	var hit_enemies = attack_area.get_overlapping_areas()
	
	# Calling the takeDamage function in the hit enemies
	for area in hit_enemies:
		var parent = area.get_parent()
		parent.takeDamage(attack_area.damage)
