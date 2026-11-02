extends CharacterBody2D

func _ready() -> void:
	$"AttackArea".set_meta("Attacking", false)
	$"../EnemySpawner/Timer".timeout.connect(connectToEnemy)
	$"../Target".release.connect(_on_target_release)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		look_at($"../Target".position)
	else:
		land(delta)
	$"AttackArea".visible = $"AttackArea".get_meta("Attacking")
	$"AttackArea/AttackHurtbox".disabled = not $"AttackArea".get_meta("Attacking")
	move_and_slide()

func land(delta) -> void:
	if velocity.x > 100 or velocity.x < -100:
		look_at($"../Target".position)
		if velocity.x > 0:
			velocity.x -= 500 * delta
		elif velocity.x < 0:
			velocity.x += 500 * delta
	else:
		rotation_degrees = -90
		velocity.x = 0



func _on_target_release(force) -> void:
	look_at($"../Target".position)
	velocity.x = transform.x.x * force
	velocity.y = transform.x.y * force
	$"AttackArea".set_meta("Attacking", true)
	await get_tree().create_timer(0.1).timeout
	$"AttackArea".set_meta("Attacking", false)

func connectToEnemy() -> void:
	var enemyPath = str($"../EnemySpawner".instance.get_path())
	get_node(enemyPath).killed.connect(afterDieBoost)


func afterDieBoost() -> void:
	_on_target_release(2000)
