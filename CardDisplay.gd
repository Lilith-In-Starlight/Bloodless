extends Button


var card :Card = null
var flipped := false


func _ready():
	update_card()


func update_card():
	$Front.visible = card != null and not flipped
	if card != null:
		$Front/ImageFrame/Image.texture = card.image
		$Front/Name.text = card.name
		$Front/AttackIcon/TextDisplay.text = str(card.strength)
		$Front/DefenseIcon/TextDisplay.text = str(card.defense)
		$Front/HealthIcon/TextDisplay.text = str(card.health)
		
		if card.hability_one != "":
			$Front/ImageFrame.texture = preload("res://CardParts/ImageFrameHability.png")
			$Front/Modifier.texture = CardManager.get_sigil_texture(card.hability_one)
		
		if card.evolve != "":
			$Front/Evolution.texture = preload("res://CardParts/EvolveTo.png")
			$Front/Evolution/TextDisplay.text = card.evolve
		elif card.require != "":
			$Front/Evolution.texture = preload("res://CardParts/EvolveFrom.png")
			$Front/Evolution/TextDisplay.text = card.require
		else:
			$Front/Evolution.texture = null
			$Front/Evolution/TextDisplay.text = ""
		
		if card.cost == 0:
			$Front/ImageFrame/CostIcon.visible = false
		elif card.cost == 1:
			$Front/ImageFrame/CostIcon.visible = true
			$Front/ImageFrame/CostIcon.position.x = 106
			$Front/ImageFrame/CostIcon/TextDisplay2.visible = false
		elif card.cost > 1:
			$Front/ImageFrame/CostIcon.visible = true
			$Front/ImageFrame/CostIcon.position.x = 96
			$Front/ImageFrame/CostIcon/TextDisplay2.visible = true
			$Front/ImageFrame/CostIcon/TextDisplay2.text = str(card.cost)

