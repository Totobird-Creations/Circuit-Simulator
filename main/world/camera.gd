extends Camera2D



export(float) var zoom_min   : float = 0.25
export(float) var zoom_max   : float = 3.0
export(float) var zoom_index : float = 0.25

var panning         : bool    = false

var target_position : Vector2 = Vector2.ZERO
var target_zoom     : float   = 1.0



func _physics_process(delta : float) -> void:
	position = position.move_toward(target_position, position.distance_to(target_position) * delta * 15.0)
	zoom.x   = move_toward(zoom.x, target_zoom, abs(zoom.x - target_zoom) * delta * 15.0)
	zoom.y   = zoom.x



func _input(event : InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index == BUTTON_MIDDLE):
			panning = event.pressed
		elif (event.button_index == BUTTON_WHEEL_UP):
			target_zoom = clamp(target_zoom - zoom_index, zoom_min, zoom_max)
		elif (event.button_index == BUTTON_WHEEL_DOWN):
			target_zoom = clamp(target_zoom + zoom_index, zoom_min, zoom_max)

	elif (event is InputEventMouseMotion):
		if (panning):
			target_position -= event.relative
