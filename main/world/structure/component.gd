extends Structure
class_name ComponentStructure



export(bool) var diode : bool = false


func get_bridges() -> Array:
	var res := [[$port_b, $port_a]]
	if (! diode):
		res.append([$port_a, $port_b])
	return res
