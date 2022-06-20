extends ResistorStructure



func _physics_process(_delta : float) -> void:
	if ($debug.visible):
		$debug.text = ""
		$debug.text +=   "ID : " + str(int(name.split("@")[-1]))
		#$debug.text += "\nV  : " + str(voltage)
		#$debug.text += "\nI  : " + str(current)
		#$debug.text += "\nR  : " + str(resistance)
	$light.visible = $arrow.visible
