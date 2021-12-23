extends Node2D


export var centered := false

var text := "" setget set_text


func set_text(value:String):
	var w := 0
	for i in get_child_count():
		get_child(i).queue_free()
	for i in value.length():
		var sprite := Sprite.new()
		sprite.position.x = w
		sprite.centered = false
		if value[i] != " ":
			var a := FontInfo.get_character(value[i])
			sprite.texture = a
			w += a.get_width() + 1
			add_child(sprite)
		else:
			sprite.texture = null
			w += 3
	if centered:
		for i in get_children():
			i.position.x -= w / 2
	text = value
