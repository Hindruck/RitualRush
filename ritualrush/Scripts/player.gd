extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HP: float = 250.0

var HP: float = 250.0
var isPlayingAnimation: bool = false
var direction 

@onready var animated_sprite_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var healthbar: ProgressBar = $HealthBar

func _ready() -> void:
	healthbar.max_value = MAX_HP
	healthbar.min_value = 0

func _physics_process(delta: float) -> void:
	# Base Health Regeneration, when not at full HP
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("move_left", "move_right")
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
			animated_sprite_player.play("Idle")
		else:
			animated_sprite_player.play("Run")	
		
		# Air Animations
		# Jump and Fall depending on the velocity
		if velocity.y < 0 and !is_on_floor():
			animated_sprite_player.play("Jump")
		elif velocity.y > 0 and !is_on_floor():
			animated_sprite_player.play("Fall")
	
	move_and_slide()


func _process(delta: float) -> void:
	healthbar.value = HP
	if HP < MAX_HP:
		heal(1 * (1 + delta/2 ))
		
	if Input.is_action_just_pressed("attack_1"):
		animated_sprite_player.stop()
		isPlayingAnimation = true
		animated_sprite_player.play("Attack_1")
		castFireBall()
	elif Input.is_action_just_pressed("attack_2"):
		animated_sprite_player.stop()
		isPlayingAnimation = true
		animated_sprite_player.play("Attack_2")
		castFireBall()	
		
func castFireBall():
	pass	
	
func takeDamage(damage: int) -> void:
	HP -= damage
	isPlayingAnimation = true
	animated_sprite_player.play("Hit")
	if HP < 0:
		death()
		
func heal(healthPoints: float) -> void:
	HP += healthPoints
	if HP > MAX_HP:
		HP = MAX_HP
	
func death():
	Engine.time_scale = 0.5
	animated_sprite_player.stop()
	isPlayingAnimation = true
	animated_sprite_player.play("Death")
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

func _on_animated_sprite_animation_finished() -> void:
	isPlayingAnimation = false
