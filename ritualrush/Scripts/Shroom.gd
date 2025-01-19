extends Enemy

@onready var spore_collision: CollisionShape2D = $Area2D/SporeCollision

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# The Idea for this was that when the Shroom Head is hit that a Spore Cloud is spawned
# !Cut from Scope!
func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
