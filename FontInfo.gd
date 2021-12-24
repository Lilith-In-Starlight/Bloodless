extends Node

const big_numbers := {
	"0" : preload("res://NumbersBig/0.png"),
	"1" : preload("res://NumbersBig/1.png"),
	"2" : preload("res://NumbersBig/2.png"),
	"3" : preload("res://NumbersBig/3.png"),
	"4" : preload("res://NumbersBig/4.png"),
}
const small_numbers := {
	"2" : preload("res://NumberSmol/2.png"),
	"3" : preload("res://NumberSmol/3.png"),
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


func get_character(c:String, small_numbers := false) -> Texture:
	var b := c.to_upper()
	if b in sprites:
		return sprites[b]
	if not small_numbers:
		return get_big_number(c)
	return get_small_number(c)


func get_big_number(c:String) -> Texture:
	if c in big_numbers:
		return big_numbers[c]
	else:
		return sprites["NoSprite"]
	

func get_small_number(c:String) -> Texture:
	if c in small_numbers:
		return small_numbers[c]
	else:
		return sprites["NoSprite"]
	
