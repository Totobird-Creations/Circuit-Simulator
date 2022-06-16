extends Control



var build_visible : bool = false



func toggle_build() -> void:
	build_visible = ! build_visible
	if (build_visible):
		$build/toggle/animation.play("main")
	else:
		$build/toggle/animation.play_backwards("main")
