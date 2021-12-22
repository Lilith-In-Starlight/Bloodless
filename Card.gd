extends Reference

class_name Card

var name := "Bamboozle"

var health := 1
var defense := 1
var strength := 1

var image :Texture
var hability_one :String = ""
var hability_two :String = ""

var require :String = ""
var evolve :String = ""


func _init(n:String, h:int = 1, d:int = 1, s:int = 1) -> void:
	name = n
	health = h
	defense = d
	strength = s
