extends Node2D


const CardDisplay := preload("res://CardDisplay.tscn")


func _ready() -> void:
	var c := CardDisplay.instance()
	c.card = CardManager.cards[0]
	add_child(c)
	c = CardDisplay.instance()
	c.card = CardManager.cards[1]
	c.position.x += 127
	add_child(c)
