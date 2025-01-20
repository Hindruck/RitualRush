extends Spell
class_name Spell_1


@onready var attack_area_spell1: AttackArea = $AttackArea
@onready var animated_sprite_spell1: AnimatedSprite2D = $AnimatedSprite2D
@onready var spell_necromancy_1: Spell_1 = $"."

func spawn(_direction: float):
	# Starts playing the animation when spawned and only is made visible when actively cast.
	isCasting = true
	spell_necromancy_1.visible = true
	animated_sprite_spell1.play("Spell")
	# Two timer start, general timer for the lifetime of the spell
	# Hit_Timer is shorter to match the animation with the damage
	timer.start()	
	hit_timer.start()
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalbusGlobal.cast_spell_1.connect(_on_necromancer_cast_spell_1)


# Function to "Turn off" the Spell when it has reached the end of its lifetime
func _on_timer_timeout() -> void:
	isCasting = false
	spell_necromancy_1.visible = false

# Function that triggers when the animation shows the correct frame
func _on_hit_timer_timeout() -> void:
	# Get an array of all enemies caught withing the spell
	var hit_enemies = attack_area_spell1.get_overlapping_bodies()
	
	if !hit_enemies.is_empty():
		# Calling the takeDamage function in the hit enemies
		for body in hit_enemies:
			var player: Player = body
			player.takeDamage(attack_area_spell1.damage)
		

func _on_necromancer_cast_spell_1() -> void:
	spawn(0)
