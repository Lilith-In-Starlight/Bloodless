extends Node


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
	
	var scared_child := Card.new("Scared Child", 2, 2, 2)
	scared_child.image = preload("res://CardParts/CardImages/ScaredChild.png")
	scared_child.hability_one = "molochian"
	scared_child.require = "The Child"
	cards.append(scared_child)


func get_sigil_texture(n:String) -> Texture:
	var m := n.to_lower()
	if m in sigils:
		return sigils[m][1]
	return null
