extends Node2D

class PlayerState:
	var lane_knowledge := [null, null, null, null]
	var hand := []
	var blood := 0
	var coins := 0

const CardDisplay := preload("res://CardDisplay.tscn")
const LaneDisplay := preload("res://LaneButton.tscn")

var card_in_hand :Card = null
var player_state := PlayerState.new()

var ai_state := PlayerState.new()

var player_lanes := []
var bot_lanes := []


var health := 23

var player_turn := true

func _ready() -> void:
	randomize()
	var c := LaneDisplay.instance()
	for i in health:
		var a := Sprite.new()
		a.texture = preload("res://Coin.png")
		a.position.y = CardManager.card_size.y + 4 + 60 + randf() * 100 - 50
		a.position.x = CardManager.card_size.x * 4 + 16 + 60 + 50 + randf() * 100
		$Pool.add_child(a)
	for i in 4:
		c = LaneDisplay.instance()
		c.position.y = CardManager.card_size.y + 4 + 60
		c.connect("player_clicked_lane", self, "_on_lane_clicked")
		c.position.x = CardManager.card_size.x * i + i*4 + 60
		player_lanes.append(c)
		add_child(c)
		
	for i in 4:
		c = LaneDisplay.instance()
		c.position.y = 60
		c.connect("player_clicked_lane", self, "_on_lane_clicked")
		c.position.x += CardManager.card_size.x * i + i*4 + 60
		bot_lanes.append(c)
		add_child(c)
	
	for i in 5:
		player_state.hand.append(CardManager.cards[randi()%CardManager.cards.size()].duplicate())
		ai_state.hand.append(CardManager.cards[randi()%CardManager.cards.size()].duplicate())
	
	
	player_state.hand.shuffle()
	update_hand()


func _on_lane_clicked(object:Node2D) -> void:
	var whostate := player_state
	if not player_turn:
		whostate = ai_state
	if card_in_hand != null:
		if object.card == null and card_in_hand.require == "":
			object.card = card_in_hand
			if object.card.hability_one == "blood_flask":
				whostate.blood += 1
			whostate.blood -= card_in_hand.cost
			card_in_hand = null
		elif object.card != null and card_in_hand.require == object.card.name:
			object.card = card_in_hand
			whostate.blood -= card_in_hand.cost
			card_in_hand = null
			if object.card.hability_one == "blood_flask":
				whostate.blood += 1
	if object.card != null and object.card.name == "Blood Flask" and card_in_hand == null and Input.is_key_pressed(KEY_SHIFT):
		object.card = null
	object.update_card()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == 2:
				if card_in_hand != null:
					var whostate := player_state
					if not player_turn:
						whostate = ai_state
					whostate.hand.append(card_in_hand)
					card_in_hand = null
					update_hand()
			elif event.button_index == 3:
				var lk := []
				for i in player_lanes:
					lk.append(i.card)
				ai_state.lane_knowledge = lk
				
				var plc := []
				var blc := []
				
				for i in 4:
					plc.append(player_lanes[i].card)
					blc.append(bot_lanes[i].card)
				
				for i in 4:
					if plc[i] != null and blc[i] != null:
						if player_turn:
							bot_lanes[i].card.health -= plc[i].strength
						else:
							player_lanes[i].card.health -= blc[i].strength
						if bot_lanes[i].card.health <= 0:
							var a :int = bot_lanes[i].card.health + bot_lanes[i].card.defense
							a = min(a, 0)
							ai_state.coins -= a
							health += a
							player_state.blood += 1
						if player_lanes[i].card.health <= 0:
							var a :int = player_lanes[i].card.health + player_lanes[i].card.defense
							a = min(a, 0)
							player_state.coins -= a
							health += a
							ai_state.blood += 1
							
					elif plc[i] != null and blc[i] == null and player_turn:
						ai_state.coins += plc[i].strength
						health -= plc[i].strength
					elif plc[i] == null and blc[i] != null and !player_turn:
						player_state.coins += blc[i].strength
						health -= blc[i].strength
				player_turn = !player_turn
				update_hand()
				
#				if !player_turn:
#					var played := false
#					var p = bot_lanes[randi()%4]
#					if ai_state.blood < 1:
#						var rand_card :Card = CardManager.make_blood_flask()
#						var done := false
#						var tries := 0
#						while not done and tries < 25:
#							tries += 1
#							if p.card == null:
#								done = true
#								p.card = rand_card
#							p = bot_lanes[randi()%4]
#					p.update_card()
#					var tries := 0
#					while played == false and tries < 25:
#						tries += 1
#						p = bot_lanes[randi()%4]
#						var rand_card :Card = ai_state.hand[randi()%ai_state.hand.size()]
#						if rand_card != null:
#							if p.card == null and rand_card.require == "":
#								p.card = rand_card
#								if p.card.hability_one == "blood_flask":
#									ai_state.blood += 1
#								ai_state.blood -= rand_card.cost
#								rand_card = null
#								played = true
#							elif p.card != null and rand_card.require == p.card.name:
#								p.card = rand_card
#								ai_state.blood -= rand_card.cost
#								rand_card = null
#								if p.card.hability_one == "blood_flask":
#									ai_state.blood += 1
#								played = true
#					if not played:
#						var rand_card :Card = CardManager.make_blood_flask()
#						var done := false
#						tries = 0
#						while not done and tries < 25:
#							tries += 1
#							if p.card == null:
#								done = true
#								p.card = rand_card
#							p = bot_lanes[randi()%4]
#					ai_state.hand.append(CardManager.cards[randi()%CardManager.cards.size()].duplicate())
#					p.update_card()
				
				for i in 4:
					if player_lanes[i].card:
						if player_lanes[i].card.health <= 0:
							player_lanes[i].card = null
					if bot_lanes[i].card:
						if bot_lanes[i].card.health <= 0:
							bot_lanes[i].card = null
						
					bot_lanes[i].update_card()
					player_lanes[i].update_card()
				update_hand()
				print(health, " | ", player_state.blood, " ", ai_state.blood)
				if player_turn:
					print("Down")
				else:
					print("Up")
				update_pool_health()


func update_hand():
	for i in $Hand.get_children():
		i.queue_free()
	var count := 0
	var whostate := player_state
	if not player_turn:
		whostate = ai_state
	for i in whostate.hand:
		var cd := CardDisplay.instance()
		cd.card = i
		cd.update_card()
		cd.rect_position.x = CardManager.card_size.x * count + count
		cd.rect_position.y = -CardManager.card_size.y/2
		cd.connect("pressed", self, "_on_HandButton_pressed", [count])
		$Hand.add_child(cd)
		count += 1


func _on_DeckButton_pressed() -> void:
	var whostate := player_state
	if not player_turn:
		whostate = ai_state
	var randcard :Card = CardManager.cards[randi()%CardManager.cards.size()].duplicate()
	whostate.hand.append(randcard)
	update_hand()


func _on_HandButton_pressed(card_number) -> void:
	var whostate := player_state
	if not player_turn:
		whostate = ai_state
	if card_in_hand == null and whostate.hand[card_number].cost <= whostate.blood:
		card_in_hand = whostate.hand[card_number]
		whostate.hand.remove(card_number)
	update_hand()


func _on_BloodDeckButton_pressed() -> void:
	var whostate := player_state
	if not player_turn:
		whostate = ai_state
	whostate.hand.append(CardManager.make_blood_flask())
	update_hand()


func update_pool_health():
	var a := $Players1.get_child_count()
	var b := $Players2.get_child_count()
	for i in player_state.coins - a:
		if i < $Pool.get_child_count():
			var c := $Pool.get_child(i)
			var s := Sprite.new()
			s.texture = preload("res://Coin.png")
			s.position = c.position
			$Players1.add_child(s)
			c.queue_free()
			var twee := Tween.new()
			twee.interpolate_property(s, "position", s.position, s.position + Vector2(randf() * 20 - 10, 150 + randf() * 20 - 10), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
			add_child(twee)
			twee.start()
	for i in ai_state.coins - b:
		if i < $Pool.get_child_count():
			var c := $Pool.get_child(i)
			var s := Sprite.new()
			s.texture = preload("res://Coin.png")
			s.position = c.position
			$Players2.add_child(s)
			c.queue_free()
			var twee := Tween.new()
			twee.interpolate_property(s, "position", s.position, s.position + Vector2(randf() * 20 - 10, -150 + randf() * 20 - 10), 0.5, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
			add_child(twee)
			twee.start()
