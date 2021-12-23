extends Node

const big_numbers := {
	"0" : preload("res://NumbersBig/0.png"),
	"1" : preload("res://NumbersBig/1.png"),
	"2" : preload("res://NumbersBig/2.png"),
	"3" : preload("res://NumbersBig/3.png"),
	"4" : preload("res://NumbersBig/4.png"),
}

var sprites := {}

func _ready() -> void:
	var d := Directory.new()
	d.open("res://Font")
	d.list_dir_begin(true)
	var file := d.get_next()
	while file != "":
		if not file.ends_with(".import"):
			var letter := file.rstrip(".png")
			sprites[letter] = load("res://Font/" + file)
		file = d.get_next()


func get_character(c:String) -> Texture:
	var b := c.to_upper()
	if b in sprites:
		return sprites[b]
	else:
		return get_big_number(c)


func get_big_number(c:String) -> Texture:
	if c in big_numbers:
		return big_numbers[c]
	else:
		return sprites["NoSprite"]
	
