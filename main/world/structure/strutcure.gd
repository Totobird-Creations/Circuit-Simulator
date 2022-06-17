extends Area2D
class_name Structure



enum State {
	PENDING,
	WORLD,
	LOCKED
}
export(State) var state : int = State.PENDING



func _physics_process(_delta : float) -> void:
	match (state):
		State.PENDING:
			var mouse := get_global_mouse_position() / 128.0
			global_position = Vector2(floor(mouse.x), floor(mouse.y)) * 128.0 + Vector2(64.0, 64.0)
