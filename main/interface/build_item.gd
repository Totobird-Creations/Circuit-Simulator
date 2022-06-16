tool
extends AspectRatioContainer



export(Texture)     var texture : Texture     setget set_texture
export(PackedScene) var scene   : PackedScene



func set_texture(value : Texture) -> void:
	texture = value
	if (get_node_or_null("texture")):
		$texture.texture = texture



func _ready() -> void:
	set_texture(texture)



func pressed() -> void:
	get_node("../../../../../../../").add_pending_structure(scene)
	get_node("../../../../../").toggle_build()
