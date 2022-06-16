extends Area2D
class_name Structure



enum State {
	PENDING,
	STATIONARY
}
var state : int = State.PENDING



func _physics_process(_delta : float) -> void:
	match (state):
		State.PENDING:
			global_position = get_global_mouse_position()
