extends Node2D



const WIRE         : PackedScene = preload("res://main/world/wire.tscn")

var   pending_wire : Wire        = null



func get_game_world() -> Node:
	return self



func add_wire(node : PortStructure) -> void:
	if (pending_wire):
		if (pending_wire.get_node_a() == node):
			return
		for wire in get_connected_wires(node):
			if (wire.get_node_a() == pending_wire.get_node_a() || wire.get_node_b() == pending_wire.get_node_a()):
				pending_wire.queue_free()
				wire.queue_free()
				pending_wire = null
				break
		if (pending_wire):
			pending_wire.node_b = weakref(node)

	pending_wire        = WIRE.instance()
	pending_wire.node_a = weakref(node)
	$wires.add_child(pending_wire)



func get_all_ports() -> Array:
	var res := []
	for child in $structures.get_children():
		if (child is PortStructure):
			res.append(child)
		else:
			for subchild in child.get_children():
				if (subchild is PortStructure):
					res.append(subchild)
	return res

func get_connected_wires(node : PortStructure) -> Array:
	var res := []
	for wire in $wires.get_children():
		if (
			(wire.get_node_a() && wire.get_node_b()) &&
			(wire.get_node_a() == node || wire.get_node_b() == node)
		):
			res.append(wire)
	return res



func _input(event : InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index == BUTTON_RIGHT && event.pressed && pending_wire):
			pending_wire.queue_free()
			pending_wire = null





func _physics_process(_delta : float) -> void:
	var groups := []
	var ports  := []
	for port in get_all_ports():
		if (! port in ports):
			groups.append([])
			var connected := port.get_connected_ports() as Array
			ports      += connected
			groups[-1] += connected

		var component := port.get_component() as ComponentStructure
		if (component):
			component.get_node("arrow").visible = false

	for i in range(len(groups)):
		for port in groups[i]:
			port.node_id = i

	var powers  := {}
	var grounds := []
	for port in ports:
		if (port.is_power && ! powers.has(port.node_id)):
			powers[port.get_component()] = port.node_id
			grounds.append(port.get_ground().node_id)

	var bridges := find_bridges(ports)
	for i in range(len(powers)):
		var paths := find_paths(powers.values()[i], grounds[i], bridges)
		if (len(paths) > 0):
			powers.keys()[i].get_node("arrow").visible = true
			for path in paths:
				for bridge in path:
					bridge[2].get_node("arrow").rotation = PI * float(bridge[0] == bridge[2].get_node("port_a").node_id)
					bridge[2].get_node("arrow").visible = true


func find_bridges(ports : Array) -> Array:
	var res   := []
	for port in ports:
		var bridges := port.get_bridges() as Array
		for bridge in bridges:
			var new_bridge := [bridge[0].node_id, bridge[1].node_id, port.get_component()]
			if (! new_bridge in res):
				res.append(new_bridge)
	return res


func find_paths(source : int, target : int, bridges : Array, path : Array = [], ignore : Array = []) -> Array:
	var res        := []
	var new_ignore := ignore + [source]

	if (source == target):
		return [path]

	for bridge in bridges:
		if (bridge[0] == source && ! bridge[1] in ignore):
			for new_res in find_paths(bridge[1], target, bridges, path + [bridge], new_ignore):
				if (! new_res in res):
					res.append(new_res)
	return res
