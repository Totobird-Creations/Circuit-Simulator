extends Node
class_name StructurePath



var paths : Array = []



func append(object : Object) -> void:
	paths.append(object)

func cleanup() -> void:
	var new_paths := []
	for path in paths:
		if (path.get_class() == get_class()):
			path.cleanup()
			if (len(path.paths) == 0):
				continue
			elif (len(path.paths) == 1):
				new_paths.append(path.paths[0])
				continue
		new_paths.append(path)
	paths = new_paths



func string_prefix() -> String:
	return ""


func to_string() -> String:
	var names := PoolStringArray()
	for path in paths:
		names.append(path.to_string())
	return string_prefix() + "(" + names.join(", ") + ")"



func free_all() -> void:
	for path in paths:
		if (path.get_class() == get_class()):
			path.free_all()
	queue_free()



func get_class() -> String:
	return "StructurePath"

func get_subclass() -> String:
	return "StructurePath"
