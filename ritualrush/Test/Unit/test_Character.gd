extends 'res://addons/gut/test.gd'

# Loading reference to player scripts and creating public variable for the player reference
var Character = load("res://Scripts/player.gd")
var _player = null

# Gets executed before each Unit Test instantiating a new Player
func before_each():
	_player = Character.new()

#Gets executed after each Unit Test freeing up the variable
func after_each():
	_player.free()

# Testing that the heal function in the player is working
func test_heal():
	_player.HP = 200.0
	var result = _player.heal(30.)
	
	assert_eq(_player.HP, 230., "HP should be 230")
	
# Testing that the player does not overheal
func test_heal_not_overheal():
	_player.HP = 200.0
	var result = _player.heal(60.)
	
	assert_eq(_player.HP, 250., "HP should be 250 and not more")	

# Throws error because of animation being played (?) in code, but that does not influence the outcome of this.	
# Tests that the player does not die when the player takes insufficient damage to die
func test_takeDamage():
	_player.HP = 200.0
	var result = double(Character).new()
	result.takeDamage(180)
	assert_not_called(result, 'death')
