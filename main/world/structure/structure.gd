extends Area2D
class_name Structure



const SNAP : float = 128.0

enum State {
	PENDING,
	WORLD,
	LOCKED
}
export(State) var state : int = State.PENDING



func unpending() -> void:
	for child in get_children():
		if (child.has_method("unpending")):
			child.unpending()



func _physics_process(_delta : float) -> void:
	match (state):
		State.PENDING:
			var mouse := get_global_mouse_position()
			var pos   := Vector2(floor(mouse.x / SNAP), floor(mouse.y / SNAP)) * SNAP
			if (get_class() == "PortStructure"):
				pos      += Vector2(SNAP / 2.0, SNAP / 2.0)
				var dist := -1.0
				for offset in [
					Vector2(-SNAP / 2.0, 0.0),
					Vector2(SNAP / 2.0, 0.0),
					Vector2(0.0, -SNAP / 2.0),
					Vector2(0.0, SNAP / 2.0)
				]:
					var new_dist := mouse.distance_to(pos + offset)
					if (dist < 0.0 || new_dist < dist):
						dist            = new_dist
						global_position = pos + offset
			else:
				global_position = pos + Vector2(SNAP / 2.0, SNAP / 2.0)
			modulate.a = 0.5

		State.WORLD:
			modulate.a = 1.0



func get_class() -> String:
	return "Structure"
