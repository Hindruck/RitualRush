extends 'res://addons/gut/test.gd'

# Loading in the path to the Enemy_base Script and creates a variable to save the instance in
var EnemyNPC = load("res://Scripts/enemy_base.gd")
var _enemy = null

# Gets executed before each Unit Test instantiating a new Enemy
func before_each():
	_enemy = EnemyNPC.new()
	
# Gets executed after each Unit Test freeing up the variable	
func after_each():
	_enemy.free()

#Throws error because of animation being played (?) in code, but that does not influence the outcome of this.
# Tests that the enemy does not die when the player takes insufficient damage to die		
func test_takeDamage():
	_enemy.HP = 200.0
	var result = _enemy.takeDamage(60.)
	
	assert_eq(_enemy.HP, 140., "HP should be 140 and not more")

# Tests that the enemy is actually set to dead when the function is called
func test_death():
	_enemy.isDead = false
	_enemy.death()
	var result = _enemy.isDead
	assert_true(result, "Enemy should be dead")		
