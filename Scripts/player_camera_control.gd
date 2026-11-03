extends Camera2D

func _process(_delta: float) -> void:
	position = Vector2($"../Player".position.x, get_distance($"../Player".position, $"../Ground".position)/2)
	if $"../Player".position.y > -500:
		zoom = Vector2(1.2-abs((get_distance($"../Player".position, $"../Ground".position)/2000) - 0.5), 1.2-abs(((get_distance($"../Player".position, $"../Ground".position)/2000) - 0.5))) #GEN what the fuck is the math behind ts
	else:
		zoom = Vector2(0.28, 0.28)

func get_distance(pos1: Vector2, pos2: Vector2) -> float:
	return pos1.y - pos2.y
