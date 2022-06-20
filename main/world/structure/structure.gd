extends Node2D
class_name Structure



const SNAP : float = 128.0

enum State {
	PENDING,
	WORLD,
	LOCKED
}
export(State) var state   : int   = State.PENDING

var               hovered : bool  = false         setget set_hovered

var               voltage : float = 1.0



func _input(event : InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index == BUTTON_LEFT && event.pressed && hovered):
			pressed_left()
		elif (event.button_index == BUTTON_MIDDLE && event.pressed && hovered):
			pressed_middle()
		elif (event.button_index == BUTTON_RIGHT && event.pressed && hovered && state in [State.PENDING, State.WORLD]):
			queue_free()



func set_hovered(value : bool) -> void:
	hovered = value && can_hover()
	if (hovered):
		$sprite.modulate = Color(1.0, 1.0, 0.0)
	else:
		$sprite.modulate = Color(1.0, 1.0, 1.0)
	#$debug.visible = hovered

func can_hover() -> bool:
	return get_game_world().pending_wire == null



func get_game_world() -> Node:
	return get_parent().get_game_world()



func unpending() -> void:
	for child in get_children():
		if (child.has_method("unpending")):
			child.unpending()



func get_bridge() -> Array:
	return []



func mouse_entered() -> void:
	self.hovered = true

func mouse_exited() -> void:
	self.hovered = false

func pressed_left() -> void:
	pass

func pressed_middle() -> void:
	pass



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
