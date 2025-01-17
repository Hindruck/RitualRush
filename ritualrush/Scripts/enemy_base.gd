extends Node2D

var direction = 1

@export var MOVESPEED = 100
@export var HP: int = 100

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
		if direction == 0:
			animated_sprite_player.play("idle")
		else:
			animated_sprite_player.play("run")	
		
	

func takeDamage(damage: int) -> void:
		HP -= damage
		
func heal(healthPoints: int) -> void:
		HP += healthPoints		
