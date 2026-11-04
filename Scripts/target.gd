extends Node2D
var isPressed = false
signal release

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if isPressed:
		position = get_global_mouse_position()

func _input(event: InputEvent) -> void:
	if event.is_action("tap"):
		isPressed = true
		if event.is_released():
			emit_signal("release", Vector2(1000, 1000), true)
			isPressed = false
