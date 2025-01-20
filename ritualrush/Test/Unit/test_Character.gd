extends 'res://addons/gut/test.gd'

var Character = load("res://Scripts/player.gd")
var _player = null


func before_each():
	_player = Character.new()
	
func after_each():
	_player.free()


func test_heal():
	_player.HP = 200.0
	var result = _player.heal(30.)
	
	assert_eq(_player.HP, 230., "HP should be 230")
	
func test_heal_not_overheal():
	_player.HP = 200.0
	var result = _player.heal(60.)
	
	assert_eq(_player.HP, 250., "HP should be 250 and not more")	

#Throws error because of animation being played (?) in code, but that does not influence the outcome of this.	
func test_takeDamage():
	_player.HP = 200.0
	var result = double(Character).new()
	result.takeDamage(180)
	assert_not_called(result, 'death')
