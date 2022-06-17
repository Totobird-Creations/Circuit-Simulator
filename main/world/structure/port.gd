extends Structure
class_name PortStructure



func unpending() -> void:
	for child in get_parent().get_children():
		if (child != self && child.get_class() == get_class() && child.global_position.distance_to(global_position) <= 0.1):
			if (state == State.LOCKED):
				child.queue_free()
			else:
				queue_free()
				break



func get_class() -> String:
	return "PortStructure"
