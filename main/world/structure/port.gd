extends Structure
class_name PortStructure



export(float) var constant_voltage : float = -1.0
export(bool)  var is_power         : bool  = false

var node_id : int   = 0
var current : float = 0.0



func _ready() -> void:
	if (constant_voltage >= 0.0):
		voltage = constant_voltage
	else:
		voltage = 0.5


func _physics_process(_delta : float) -> void:
	if ($debug.visible):
		$debug.text = ""
		$debug.text +=   "Id : " + str(node_id)
		$debug.text += "\nV  : " + str(voltage)
		$debug.text += "\nI  : " + str(current)



func can_hover() -> bool:
	return (
		get_game_world().pending_wire == null || (
			get_game_world().pending_wire != null && 
			get_game_world().pending_wire.get_node_a() != self
		)
	)



func unpending() -> void:
	for child in get_all_near_ports():
		if (child.state != State.LOCKED):
			for wire in get_game_world().get_connected_wires(child):
				if (wire.get_node_a() == child):
					wire.node_a = weakref(self)
				elif (wire.get_node_b() == child):
					wire.node_b = weakref(self)
			child.queue_free()
		elif (state != State.LOCKED):
			queue_free()
			break

func get_all_near_ports() -> Array:
	var res := []
	for port in get_game_world().get_all_ports():
		if (port != self && global_position.distance_to(port.global_position) <= 0.1):
			res.append(port)
	return res



func pressed_left() -> void:
	mouse_exited()
	get_game_world().add_wire(self)



func get_connected_ports(ignore : Array = []) -> Array:
	var res        := [self] + get_all_near_ports()
	var new_ignore := ignore + [self]
	var wires      := get_game_world().get_connected_wires(self) as Array
	for wire in wires:
		var node_a := wire.get_node_a() as PortStructure
		var node_b := wire.get_node_b() as PortStructure
		if (! node_a in new_ignore):
			res += node_a.get_connected_ports(new_ignore)
		if (! node_b in new_ignore):
			res += node_b.get_connected_ports(new_ignore)
	return res


func get_component() -> ComponentStructure:
	if (get_parent() is ComponentStructure):
		return get_parent() as ComponentStructure
	return null


func get_bridges() -> Array:
	var component := get_component()
	if (component):
		return component.get_bridges()
	return []


func get_ground() -> PortStructure:
	if (get_parent() is BatteryStructure):
		return get_parent().get_node("port_b") as PortStructure
	return null



func get_class() -> String:
	return "PortStructure"
