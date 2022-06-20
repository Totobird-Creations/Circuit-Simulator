extends Node2D
class_name Structure



const SNAP : float = 128.0

enum State {
	PENDING,
	WORLD,
	LOCKED
}
export(State) var state : int = State.PENDING



func get_game_world() -> Node:
	return get_parent().get_game_world()



func unpending() -> void:
	for child in get_children():
		if (child.has_method("unpending")):
			child.unpending()



func _physics_process(_delta : float) -> void:
	match (state):
		State.PENDING:
			var mouse       := get_global_mouse_position()
			var pos         := Vector2(floor(mouse.x / SNAP), floor(mouse.y / SNAP)) * SNAP
			global_position  = pos + Vector2(SNAP / 2.0, SNAP / 2.0)
			modulate.a = 0.5

		State.WORLD:
			modulate.a = 1.0



func get_class() -> String:
	return "Structure"
