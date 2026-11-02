extends CharacterBody2D
@onready var initY = position.y
var rng = RandomNumberGenerator.new()
signal killed

func _ready() -> void:
	position.x = $"../Player".position.x
	var leftRight = rng.randi_range(-1, 1)
	position.x += 800 * leftRight
	position.x += rng.randf_range(50, 300) * leftRight
	$"AnimationPlayer".play("floatUpDown", -1, 1, false)
	$"../Player/AttackArea".area_entered.connect(_die)

func _process(_delta: float) -> void:
	position.y = initY + get_meta("floatyNum")

func _die(area: Area2D) -> void:
	if area == $EnemyHitbox:
		killed.emit()
		self.queue_free()
