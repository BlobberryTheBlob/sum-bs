extends Node2D
var rng = RandomNumberGenerator.new()
const ENEMY = preload("res://Objects/enemy.tscn")
var instance
var enemies = [preload("res://Objects/enemy.tscn")]



func _ready() -> void:
	$Timer.timeout.connect(_spawn_enemy)



func _spawn_enemy() -> void:
	if $"../Camera2D".playerAlive:
		$Timer.wait_time = rng.randf_range(1, 4)
		instance = ENEMY.instantiate()
		$"..".add_child(instance)
