tool
extends AspectRatioContainer



export(Texture) var texture : Texture setget set_texture



func set_texture(value : Texture) -> void:
	texture = value
	if (get_node_or_null("texture")):
		$texture.texture = texture



func _ready() -> void:
	set_texture(texture)
