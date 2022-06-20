extends ResistorStructure



const TEXTURE_OPEN   : Texture = preload("res://assets/texture/structure/switch_open.png")
const TEXTURE_CLOSED : Texture = preload("res://assets/texture/structure/switch_closed.png")

var   closed         : bool    = false                                                       setget set_closed



func set_closed(value : bool) -> void:
	closed = value
	$sprite.texture = [TEXTURE_OPEN, TEXTURE_CLOSED][int(closed)]


func get_bridges() -> Array:
	if (closed):
		return [[$port_b, $port_a], [$port_a, $port_b]]
	else:
		return []



func pressed_middle() -> void:
	print("yep")
	self.closed = ! closed
