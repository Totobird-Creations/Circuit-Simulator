extends Node2D



func get_game_world() -> Node:
	return get_parent().get_game_world()
