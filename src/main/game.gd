extends Node



func add_pending_structure(instance : Structure):
	$canvas/screen.visible = true
	$world/pending.add_child(instance)
	instance.state = Structure.State.PENDING



func _input(event : InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.pressed):

			if (event.button_index == BUTTON_LEFT):
				for child in $world/pending.get_children():
					$world/pending.remove_child(child)
					$world/structures.add_child(child)
					child.state = Structure.State.WORLD
					child.unpending()
				$canvas/screen.visible = false

			elif (event.button_index == BUTTON_RIGHT):
				for child in $world/pending.get_children():
					child.queue_free()
				$canvas/screen.visible = false

			elif ($world/pending.get_child_count() > 0):
				if (event.button_index == BUTTON_WHEEL_UP):
					for child in $world/pending.get_children():
						child.rotation -= PI / 2.0

				elif (event.button_index == BUTTON_WHEEL_DOWN):
					for child in $world/pending.get_children():
						child.rotation += PI / 2.0

			else:
				if (event.button_index == BUTTON_WHEEL_UP):
					$world/camera.target_zoom = clamp($world/camera.target_zoom - $world/camera.zoom_index, $world/camera.zoom_min, $world/camera.zoom_max)

				elif (event.button_index == BUTTON_WHEEL_DOWN):
					$world/camera.target_zoom = clamp($world/camera.target_zoom + $world/camera.zoom_index, $world/camera.zoom_min, $world/camera.zoom_max)
