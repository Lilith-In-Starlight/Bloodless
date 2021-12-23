extends Node2D

signal player_clicked_lane(object)

var card :Card = null

func _ready() -> void:
	update_card()


func update_card():
	$CardDisplay.card = card
	$CardDisplay.update_card()


func _on_CardDisplay_pressed() -> void:
	emit_signal("player_clicked_lane", self)
