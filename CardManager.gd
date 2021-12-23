extends Node

const card_size := Vector2(126, 176)

var cards := []

const sigils := {
	"molochian" : ["Molochian", preload("res://CardParts/Sigils/Molochian.png"), "When this card dies, it becomes stronger. When it kills something it becomes weaker."]
}


func _ready() -> void:
	var child := Card.new("The Child", 2, 2, 2)
	child.image = preload("res://CardParts/CardImages/Child.png")
	child.hability_one = "molochian"
	child.evolve = "Scared Child"
	cards.append(child)
	
	var scared_child := Card.new("Scared Child", 4, 3, 2)
	scared_child.image = preload("res://CardParts/CardImages/ScaredChild.png")
	scared_child.hability_one = "molochian"
	scared_child.require = "The Child"
	cards.append(scared_child)
	
	var cat := Card.new("Cat", 2, 1, 2)
	cat.image = preload("res://CardParts/CardImages/Cat.png")
	cards.append(cat)


func get_sigil_texture(n:String) -> Texture:
	var m := n.to_lower()
	if m in sigils:
		return sigils[m][1]
	return null


func make_blood_flask() -> Card:
	var blood := Card.new("Blood Flask", 1, 0, 1)
	blood.image = preload("res://CardParts/CardImages/BloodFlask.png")
	return blood
