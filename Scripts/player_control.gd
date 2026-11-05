extends CharacterBody2D
var landing = false
signal game_over

func _ready() -> void:
	$"AttackArea".set_meta("Attacking", false)
	$"../EnemySpawner/Timer".timeout.connect(_connect_to_enemy)
	$"../Target".release.connect(_on_target_release)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		look_at($"../Target".position)
		landing = false
	else:
		_land(delta)
	$"AttackArea".visible = $"AttackArea".get_meta("Attacking")
	$"AttackArea/AttackHurtbox".disabled = not $"AttackArea".get_meta("Attacking")
	move_and_slide()

func _land(delta) -> void:
	rotation_degrees = -90
	if abs(velocity.x) > 100 and not $AttackArea.get_meta("Attacking"):
		if velocity.x > 0:
			velocity.x -= 500 * delta
		elif velocity.x < 0:
			velocity.x += 500 * delta
		if abs(velocity.x) > 1500:
			landing = true
	else:
		landing = false
		velocity.x = 0



func _on_target_release(force: Vector2, attack: bool) -> void:
	if not landing:
		look_at($"../Target".position)
		velocity.x = transform.x.x * force.x
		velocity.y = transform.x.y * force.y
		await get_tree().create_timer(0.05).timeout
		if attack:
			$"AttackArea".set_meta("Attacking", true)
			await get_tree().create_timer(0.1).timeout
			$"AttackArea".set_meta("Attacking", false)

func _connect_to_enemy() -> void:
	var enemyPath = str($"../EnemySpawner".instance.get_path())
	get_node(enemyPath).killed.connect(_after_kill_boost)
	get_node(enemyPath).area_entered.connect(_die)


func _after_kill_boost() -> void:
	_on_target_release(Vector2(abs(velocity.x) + 1000, abs(velocity.y) + 1000), false)

func _die(area: Area2D) -> void:
	if area == $Hitbox:
		game_over.emit()
		self.queue_free()
