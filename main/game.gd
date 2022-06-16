extends Node



func add_pending_structure(scene : PackedScene):
	$canvas/screen.visible = true
	var instance := scene.instance()
	$world/pending.add_child(instance)
