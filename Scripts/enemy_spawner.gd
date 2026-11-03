extends Node2D
var rng = RandomNumberGenerator.new()
const ENEMY = preload("uid://dfp781m2mjv3w")
var instance

func _ready() -> void:
	$Timer.timeout.connect(spawnEnemy)



func spawnEnemy() -> void:
	$Timer.wait_time = rng.randf_range(1, 4)
	instance = ENEMY.instantiate()
	$"..".add_child(instance)
