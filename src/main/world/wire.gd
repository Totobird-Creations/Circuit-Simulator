extends Node2D
class_name Wire



var node_a : WeakRef
var node_b : WeakRef



func _physics_process(_delta : float) -> void:
	var mouse  := get_global_mouse_position()
	var points := PoolVector2Array([mouse, mouse])
	var nodes  := [get_node_a(), get_node_b()]
	for i in range(len(nodes)):
		if (nodes[i]):
			points[i] = nodes[i].global_position
	$background.points = points
	$line.points       = points
	if (node_a && node_b && (
		! get_node_a() || ! get_node_b()
	)):
		queue_free()



func get_node_a() -> Node:
	if (node_a && node_a.get_ref()):
		return node_a.get_ref()
	return null

func get_node_b() -> Node:
	if (node_b && node_b.get_ref()):
		return node_b.get_ref()
	return null
