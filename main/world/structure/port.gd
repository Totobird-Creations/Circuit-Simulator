extends Structure
class_name PortStructure



var hovered : bool = false setget set_hovered



func set_hovered(value : bool) -> void:
	hovered = value
	if (hovered):
		$sprite.modulate = Color(1.0, 1.0, 0.0)
	else:
		$sprite.modulate = Color(1.0, 1.0, 1.0)



func unpending() -> void:
	for child in get_all_near_portstructures(get_game_world(), [self]):
		if (child.state != State.LOCKED):
			child.queue_free()
		elif (state != State.LOCKED):
			queue_free()
			break

func get_all_near_portstructures(node : Node, ignore : Array) -> Array:
	var res := []
	if (! node in ignore && node.get_class() == get_class() && global_position.distance_to(node.global_position) <= 0.1):
		res.append(node)
	for child in node.get_children():
		res += get_all_near_portstructures(child, ignore)
	return res



func mouse_entered() -> void:
	self.hovered = true

func mouse_exited() -> void:
	self.hovered = false



func get_class() -> String:
	return "PortStructure"
