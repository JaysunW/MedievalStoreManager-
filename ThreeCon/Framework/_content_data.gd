class_name container_content

var texture = null
var type = ""
var special = false

func _init(_texture, _type, _special = false):
	texture = _texture
	type = _type
	special = _special
		
func change_content(_texture, _type, _special = false):
	texture = _texture
	type = _type
	special = _special
	
func get_texture():
	return texture

func get_type():
	return type

func is_special():
	return special
