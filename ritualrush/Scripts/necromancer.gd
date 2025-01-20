extends Enemy

var isNecromancerDead := false
var isPlayerInRange := false
var isOnCooldown := false
var spell1Cast := false

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
	pass

func _physics_process(_delta: float) -> void:
	if !isOnCooldown:
		super(_delta)
	if !isDead:		
		if ray_cast_short.is_colliding():
			spell_1_timer.wait_time = 2
		elif ray_cast_long.is_colliding():
			spell_1_timer.wait_time = 3
			spell_2_timer.autostart = true
			spell_2_timer.start()
			isPlayerInRange = true
		elif !ray_cast_long.is_colliding() && !ray_cast_short.is_colliding():	
			spell_1_timer.wait_time = 5
			spell_2_timer.autostart = false

		
	
func takeDamage(damage: int) -> void:
	super(damage)	
	
func death():
	Engine.time_scale = 0.5
	isNecromancerDead = true
	isPlayingAnimation = true
	spell_1_timer.stop()
	spell_2_timer.stop()
	animated_sprite_necromancer.play("Death")
	
func _on_animated_sprite_animation_finished() -> void:
	if isNecromancerDead :
		Engine.time_scale = 1
		queue_free()
	else:
		isPlayingAnimation = false


func _on_spell_1_timer_timeout() -> void:
	#if !isOnCooldown:
		isOnCooldown = true
		animated_sprite_necromancer.play("Attack_1")
		SignalbusGlobal.cast_spell_1.emit()


func _on_spell_2_timer_timeout() -> void:
	#if !isOnCooldown:
		isOnCooldown = true
		animated_sprite_necromancer.play("Attack_2")
		SignalbusGlobal.cast_spell_2.emit()


func _on_animated_sprite_necromancer_animation_finished() -> void:
	isOnCooldown = false
