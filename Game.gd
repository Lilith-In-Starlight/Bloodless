extends Node2D


const CardDisplay := preload("res://CardDisplay.tscn")
const LaneDisplay := preload("res://LaneButton.tscn")

var card_in_hand :Card = null
var hand := []


func _ready() -> void:
	randomize()
	var c := LaneDisplay.instance()
	c.connect("player_clicked_lane", self, "_on_lane_clicked")
	add_child(c)
	c = LaneDisplay.instance()
	c.position.x += 127
	c.connect("player_clicked_lane", self, "_on_lane_clicked")
	add_child(c)
	
	for i in 3:
		hand.append(CardManager.cards[randi()%CardManager.cards.size()])
	for i in 3:
		hand.append(CardManager.cards[2])
	
	hand.shuffle()
	update_hand()


func _on_lane_clicked(object:Node2D) -> void:
	if object.card == null and card_in_hand != null:
		object.card = card_in_hand
		card_in_hand = null
	object.update_card()


func update_hand():
	for i in $Hand.get_children():
		i.queue_free()
	var count := 0
	for i in hand:
		var cd := CardDisplay.instance()
		cd.card = i
		cd.update_card()
		cd.rect_position.x = CardManager.card_size.x * count + count
		cd.rect_position.y = -CardManager.card_size.y/2
		cd.connect("pressed", self, "_on_HandButton_pressed", [count])
		$Hand.add_child(cd)
		count += 1


func _on_DeckButton_pressed() -> void:
	hand.append(CardManager.cards[randi()%CardManager.cards.size()])
	update_hand()


func _on_HandButton_pressed(card_number) -> void:
	if card_in_hand == null:
		card_in_hand = hand[card_number]
		hand.remove(card_number)
	update_hand()




func _on_BloodDeckButton_pressed() -> void:
	hand.append(CardManager.make_blood_flask())
	update_hand()
