extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var HP: int = 250
var isPlayingAnimation: bool = false 

@onready var animated_sprite_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer


func _physics_process(delta: float) -> void:
	# Base Health Regeneration, when not at full HP
	if HP < 250:
		heal(1 * int(delta))
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Flip to face the direction of the movement
	if direction > 0:
		animated_sprite_player.flip_h = false
	elif direction < 0:
		animated_sprite_player.flip_h = true
	
	# Only updating the movement Animations when no other animation is played
	if !isPlayingAnimation:
		# Movement Animations
		# Idle when not moving and Run when moving in any direction
		if direction == 0:
			animated_sprite_player.play("idle")
		else:
			animated_sprite_player.play("run")	
		
		# Air Animations
		# Jump and Fall depending on the velocity
		if velocity.y < 0 and !is_on_floor():
			animated_sprite_player.play("jump")
		elif velocity.y > 0 and !is_on_floor():
			animated_sprite_player.play("fall")
	
	move_and_slide()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack_1"):
		var FireBall: Spell_Fireball = new Spell_FireBall
		
	
func takeDamage(damage: int) -> void:
		HP -= damage
		if HP < 0:
			Engine.time_scale = 0.5
			animated_sprite_player.stop()
			animated_sprite_player.play("death")
			timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

		
func heal(healthPoints: int) -> void:
		HP += healthPoints	
