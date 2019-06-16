extends Area2D

var monsterTypeId: int
var bodyPartId: int
var populated = false

func _on_BodyPartSlot_body_entered(body):
	monsterTypeId = body.monsterTypeId
	bodyPartId = body.bodyPartId
	populated = true
	self.get_node("Sprite").set_texture(load("res://Assets/slots/slot-populated.png"))

func _on_BodyPartSlot_body_exited(body):
	monsterTypeId = 0
	bodyPartId = 0
	populated = false
	self.get_node("Sprite").set_texture(load("res://Assets/slots/slot.png"))
