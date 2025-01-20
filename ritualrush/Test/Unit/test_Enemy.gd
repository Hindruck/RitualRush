extends 'res://addons/gut/test.gd'

var EnemyNPC = load("res://Scripts/enemy_base.gd")
var _enemy = null


func before_each():
	_enemy = EnemyNPC.new()
	
func after_each():
	_enemy.free()

#Throws error because of animation being played (?) in code, but that does not influence the outcome of this.		
func test_takeDamage():
	_enemy.HP = 200.0
	var result = _enemy.takeDamage(60.)
	
	assert_eq(_enemy.HP, 140., "HP should be 140 and not more")

func test_death():
	_enemy.isDead = false
	_enemy.death()
	var result = _enemy.isDead
	assert_true(result, "Enemy should be dead")		
