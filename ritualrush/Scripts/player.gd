extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_HP: float = 250.0

var HP: float = 250.0
var isPlayingAnimation: bool = false
var isCasting: bool = false
var direction 

@onready var fireball: Spell = $Fireball
@onready var attack_area: AttackArea = $AttackArea
@onready var attack_2_area: CollisionShape2D = $AttackArea/attack_2_area
@onready var animated_sprite_player: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer
@onready var healthbar: ProgressBar = $HealthBar

func _ready() -> void:
	# Setting Healthbar values automatically to set variables
	healthbar.max_value = MAX_HP
	healthbar.min_value = 0

func _physics_process(delta: float) -> void:
		
	# Add the gravity if player is not on the floor.
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
	
	# Flip to face the direction of the movement and sets the melee attack direction depending on movement direction
	if direction > 0:
		animated_sprite_player.flip_h = false
		attack_2_area.position.x = 70
	elif direction < 0:
		animated_sprite_player.flip_h = true
		attack_2_area.position.x = -70
	
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
	
	# Move the character
	move_and_slide()


func _process(delta: float) -> void:
	# Base Health Regeneration, when not at full HP
	healthbar.value = HP
	if HP < MAX_HP:
		heal(1 * (1 + delta/2 ))
	
	# Only allowing casting, when the player is not already casting a spell to attack
	if fireball.isCasting == false || !isCasting:	
		# Attack 1 - Ranged Attack, Fireball. Stopping animation that was running and making sure,
		# it does not get overwritten while playing
		if Input.is_action_just_pressed("attack_1"):
			animated_sprite_player.stop()
			isPlayingAnimation = true
			animated_sprite_player.play("Attack_1")
			castFireBall()
		# Attack 2 - Melee Attack, Magic Burst
		elif Input.is_action_just_pressed("attack_2"):
			isPlayingAnimation = true
			isCasting = true
			animated_sprite_player.play("Attack_2")
			castMagicBurst()

# Function to cast fireball. For now it only calls the spawn function in the fireball spell with a direction input				
func castFireBall():
	fireball.spawn(direction)
	
# Function to cast Magic Burst. 
# Since the Hitbox is connected to the player directly the code is based in the player script.
func castMagicBurst():
	# Getting an Array of the Hit Enemies
	var overlapping_Enemies = attack_area.get_overlapping_areas()
	
	# Iterating through the hit Enemy Hurtboxes and calling the "takeDamage" function in the parent of the Box
	for area in overlapping_Enemies:
		var parent = area.get_parent()
		parent.takeDamage(attack_area.damage)	
	# Setting the boolean isCasting to false. Allowing a new spell to be cast
	isCasting = false

# Function to reduce the HP of the player. 
# Reducing the HP value and playing the "Hit" Animation		
func takeDamage(damage: int) -> void:
	HP -= damage
	isPlayingAnimation = true
	animated_sprite_player.play("Hit")
	# If the Player HP reaches below 0 the "death" function gets called
	if HP < 0:
		death()

# Function to heal the player. Implemented in this way with the option of heal collectables in the future in mind.		
func heal(healthPoints: float) -> void:
	HP += healthPoints
	# Only healing to max hp and not overhealing
	if HP > MAX_HP:
		HP = MAX_HP
		
# Function that handles the player death. Entering Slomo and playing death animation	
func death():
	Engine.time_scale = 0.5
	animated_sprite_player.stop()
	isPlayingAnimation = true
	animated_sprite_player.play("Death")
	# Starting a timer to let the death really sink in
	timer.start()

# When the Death Timer runs out the game time is reset back to normal and the game start again from the start
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()

# When a non looping animation finishes this makes sure that the regular movement animations can run again
func _on_animated_sprite_animation_finished() -> void:
	isPlayingAnimation = false
