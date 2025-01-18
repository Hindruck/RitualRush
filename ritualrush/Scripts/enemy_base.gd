extends Node2D
class_name Enemy

var direction = 1
var isPlayingAnimation := false
var isDead := false

@export var MOVESPEED = 100
@export var HP: float = 100

@onready var ray_cast_left: RayCast2D = $AnimatedSprite2D/RayCastLeft
@onready var ray_cast_right: RayCast2D = $AnimatedSprite2D/RayCastRight
@onready var animated_sprite_player: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_player.flip_h = false
	elif ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_player.flip_h = true
	
	
	position.x += MOVESPEED * delta * direction

func _physics_process(delta: float) -> void:
	if !isPlayingAnimation:
		if direction == 0:
			animated_sprite_player.play("Idle")
		else:
			animated_sprite_player.play("Run")	
		
	

func takeDamage(damage: int) -> void:
	HP -= damage
	isPlayingAnimation = true
	animated_sprite_player.play("Hit")
	if HP < 0:
		death()
		
func death():
	isDead = true
	isPlayingAnimation = true
	animated_sprite_player.play("Death")
		



func _on_animated_sprite_animation_finished() -> void:
	if isDead:
		queue_free()
	else:
		isPlayingAnimation = false
