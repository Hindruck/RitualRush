# Extends Enemy, this makes the Necromancer Script a Sub-Class from Enemy
extends Enemy

# Creating a few booleans that are needed across the entire class
var isNecromancerDead := false
var isOnCooldown := false
# Saving references from the assets to be used in the code
@onready var ray_cast_short: RayCast2D = $AnimatedSprite2D/RayCastShort
@onready var ray_cast_long: RayCast2D = $AnimatedSprite2D/RayCastLong
@onready var animated_sprite_necromancer: AnimatedSprite2D = $AnimatedSprite2D
@onready var spell_1_timer: Timer = $Spell1Timer
@onready var spell_2_timer: Timer = $Spell2Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HP = 350
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:	
	if !isDead:		
		# Sets the shorter casting time the closer the player is to the boss
		if ray_cast_short.is_colliding():
			spell_1_timer.wait_time = 2
		elif ray_cast_long.is_colliding():
			spell_1_timer.wait_time = 3			
		
			
		# Turns on the secondary Spell casting, when the player gets close and resets back to default, when player out of range
		if ray_cast_short.is_colliding() || ray_cast_long.is_colliding():	
			spell_2_timer.autostart = true
			spell_2_timer.start()	
		elif !ray_cast_long.is_colliding() && !ray_cast_short.is_colliding():	
			spell_1_timer.wait_time = 5
			spell_2_timer.autostart = false	

# Physics process that runs the parent code when isOnCooldown is false
func _physics_process(_delta: float) -> void:
	if !isOnCooldown:
		super(_delta)
	

		
# Function that calculates the damage taken by the Enemy.
# Using parent function with super()	
func takeDamage(damage: int) -> void:
	super(damage)	

# Function that handles the Necromancers Death	
func death():
	Engine.time_scale = 0.5
	isNecromancerDead = true
	isPlayingAnimation = true
	spell_1_timer.stop()
	spell_2_timer.stop()
	animated_sprite_necromancer.play("Death")


# When the Spell1Timer completes a cycle this function gets called and emits a signal that activated all instances of the spell
func _on_spell_1_timer_timeout() -> void:	
	isOnCooldown = true
	isPlayingAnimation = true
	animated_sprite_necromancer.play("Attack_1")
	SignalbusGlobal.cast_Spell_1.emit()

# When the Spell2Timer completes a cycle this function gets called and emits a signal that activated all instances of the spell
func _on_spell_2_timer_timeout() -> void:
	isOnCooldown = true
	isPlayingAnimation = true
	animated_sprite_necromancer.play("Attack_2")
	SignalbusGlobal.cast_Spell_2.emit()

# When an non-looping animation finishes this function is called
# When the Necromancer is dead at this point the engine gets set back to normal speed and the necromancer gets destroyed	
func _on_animated_sprite_necromancer_animation_finished() -> void:
	if isNecromancerDead :
		Engine.time_scale = 1
		queue_free()
	else:
		isPlayingAnimation = false
		isOnCooldown = false
