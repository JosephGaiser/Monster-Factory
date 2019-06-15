extends Area2D

var conveyerSpeed = -0.2

const bodyPart = preload("res://BodyPart.tscn")

func _ready():
	var sprite = get_node("Sprite")
	sprite.play("Moving")
	createPart()
	

func _on_ConveyerBelt_body_entered(body):
	body.apply_central_impulse(Vector2(conveyerSpeed, 0))


func createPart():
	var part = bodyPart.instance()
	part.bodyPartId = 1
	part.monsterTypeId = 1
	part.add_to_group("pickable")
	part.connect("clicked", self, "_on_pickable_clicked")
	$GridContainer.add_child(part)