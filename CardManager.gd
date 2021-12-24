extends Node

const card_size := Vector2(126, 176)

var cards := []

var default_deck := []
var default_deck2 := []

const sigils := {
	"molochian" : ["Molochian", preload("res://CardParts/Sigils/Molochian.png"), "When this card dies, it becomes stronger. When it kills something it becomes weaker."],
	"blood_flask" : ["Blood Flask", preload("res://CardParts/Sigils/BloodFlask.png"), "When this card is placed, the player gets +1 blood."],
}


func _ready() -> void:
	var child := Card.new("The Child", 2, 2, 2, 4)
	child.image = preload("res://CardParts/CardImages/Child.png")
	child.hability_one = "molochian"
	child.evolve = "Scared Child"
	cards.append(child)
	
	var scared_child := Card.new("Scared Child", 4, 3, 2, 4)
	scared_child.image = preload("res://CardParts/CardImages/ScaredChild.png")
	scared_child.hability_one = "molochian"
	scared_child.require = "The Child"
	cards.append(scared_child)
	
	var cat := Card.new("Cat", 2, 1, 1, 2)
	cat.image = preload("res://CardParts/CardImages/Cat.png")
	cards.append(cat)
	
	var dog := Card.new("Dog", 1, 1, 1, 1)
	dog.image = preload("res://CardParts/CardImages/Dog.png")
	cards.append(dog)
	
	var mosquito := Card.new("Mosquito", 1, 1, 1, 1)
	mosquito.image = preload("res://CardParts/CardImages/Mosquito.png")
	cards.append(mosquito)
	
	var centi := Card.new("Centipede", 1, 1, 2, 2)
	centi.image = preload("res://CardParts/CardImages/Centipede.png")
	cards.append(centi)
	
	var fyre := Card.new("Fyre", 1, 0, 2, 2)
	fyre.image = preload("res://CardParts/CardImages/Fyre.png")
	cards.append(fyre)
	
	var silkworm := Card.new("Silkworm", 2, 3, 1, 4)
	silkworm.image = preload("res://CardParts/CardImages/Silkworm.png")
	cards.append(silkworm)
	
	for i in 6:
		default_deck.append(dog.duplicate())
		default_deck2.append(dog.duplicate())
	for i in 6:
		default_deck.append(mosquito.duplicate())
		default_deck2.append(mosquito.duplicate())
	for i in 3:
		default_deck.append(cat.duplicate())
		default_deck2.append(cat.duplicate())
	for i in 2:
		default_deck.append(centi.duplicate())
		default_deck2.append(centi.duplicate())
	for i in 2:
		default_deck.append(fyre.duplicate())
		default_deck2.append(fyre.duplicate())
	for i in 2:
		default_deck.append(child.duplicate())
		default_deck2.append(child.duplicate())
	for i in 1:
		default_deck.append(scared_child.duplicate())
		default_deck2.append(scared_child.duplicate())
	for i in 2:
		default_deck.append(silkworm.duplicate())
		default_deck2.append(silkworm.duplicate())

func get_sigil_texture(n:String) -> Texture:
	var m := n.to_lower()
	if m in sigils:
		return sigils[m][1]
	return null


func make_blood_flask() -> Card:
	var blood := Card.new("Blood Flask", 1, 0, 0, 0)
	blood.image = preload("res://CardParts/CardImages/BloodFlask.png")
	blood.hability_one = "blood_flask"
	return blood
