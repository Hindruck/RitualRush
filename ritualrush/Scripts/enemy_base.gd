extends Node2D
# Setting the class name to have all Enemies categorized
class_name Enemy

# Declaring variables that are needed throughout the class
var direction = 1
var isPlayingAnimation := false
var isDead := false

# Public variables to be set in the editor without needing to change any code
@export var MOVESPEED = 100
@export var HP: float = 100

# Scene references needed to control the enemy
@onready var ray_cast_left: RayCast2D = $AnimatedSprite2D/RayCastLeft
@onready var ray_cast_right: RayCast2D = $AnimatedSprite2D/RayCastRight
@onready var animated_sprite_enemy: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Checking the Left and Right for walls and turning around when hitting one side
	# Basically making them ping-pong between walls
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_enemy.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_enemy.flip_h = true
	
	# Moving the Enemy
	position.x += MOVESPEED * delta * direction

# Setting the animations regarding the npcs current walking state
func _physics_process(_delta: float) -> void:
	if !isPlayingAnimation:
		if direction == 0:
			animated_sprite_enemy.play("Idle")
		else:
			animated_sprite_enemy.play("Run")	
		
	
# Function that automatically reduced the HP of the Enemy
# When HP less than 0 the Death function gets called
func takeDamage(damage: int) -> void:
	HP -= damage
	isPlayingAnimation = true
	animated_sprite_enemy.play("Hit")
	if HP < 0:
		death()

# Function to handle the death of the NPC
# Works like the player script, with the difference, that the collision is disabled when dead to not deal damage when dead		
func death():
	isDead = true
	isPlayingAnimation = true
	animated_sprite_enemy.play("Death")
			


# When a non-looping animation finishes playing this function is called
# If the Enemy is dead then it gets deleted from the level otherwise it allows walking animations to trigger
func _on_animated_sprite_animation_finished() -> void:
	if isDead:
		queue_free()
	else:
		isPlayingAnimation = false
