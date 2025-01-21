extends Spell
class_name Spell_2

# Saving References to assets
@onready var attack_area_spell2: AttackArea = $AttackArea
@onready var animated_sprite_spell2: AnimatedSprite2D = $AnimatedSprite2D
@onready var spell_necromancy_2: Spell_2 = $"."

func spawn(_direction: float):
		# Starts playing the animation when spawned and only is made visible when actively cast.
		isCasting = true
		spell_necromancy_2.visible = true
		animated_sprite_spell2.play("Spell")
		# Two timer start, general timer for the lifetime of the spell
		# Hit_Timer is shorter to match the animation with the damage
		timer.start()	
		hit_timer.start()
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connecting to the Signal cast_spell_2 from the Signalbus	
	SignalbusGlobal.cast_Spell_2.connect(_on_necromancer_cast_spell_2)


# Function to "Turn off" the Spell when it has reached the end of its lifetime
func _on_timer_timeout() -> void:
	isCasting = false
	spell_necromancy_2.visible = false

# Function that triggers when the animation shows the correct frame
func _on_hit_timer_timeout() -> void:
	# Get an array of all enemies caught withing the spell
	var hit_enemies = attack_area_spell2.get_overlapping_bodies()
	
	if !hit_enemies.is_empty():
		# Calling the takeDamage function in the hit enemies
		for body in hit_enemies:
			var player: Player = body
			player.takeDamage(attack_area_spell2.damage)

# This function gets called when the signal is emitted
func _on_necromancer_cast_spell_2() -> void:
	spawn(0)
