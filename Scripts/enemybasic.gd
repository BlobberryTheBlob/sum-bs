extends CharacterBody2D
@onready var initY = position.y
var rng = RandomNumberGenerator.new()
signal killed
var speed

func _ready() -> void:
	position.x = $"../Player".position.x
	var leftRight = rng.randi_range(0, 1)
	position.x += -800 + (1600 * leftRight)
	position.x += rng.randf_range(50, 300) * leftRight
	$"AnimationPlayer".play("floatUpDown", -1, 1, false)
	$"../Player/AttackArea".area_entered.connect(_die)
	speed = rng.randf_range(50, 150)

func _physics_process(delta: float) -> void:
	position.x = move_toward(position.x, $'../Player'.position.x, speed * delta)
	position.y = initY + get_meta("floatyNum")

func _die(area: Area2D) -> void:
	if area == $EnemyHitbox:
		get_tree().paused = true
		await get_tree().create_timer(0.1).timeout
		get_tree().paused = false
		killed.emit()
		self.queue_free()
