extends Area2D

export var monsterTypeId: int
export var bodyPartId: int
var populatedMonsterTypeId: int
var populatedBodyPartId: int
var populated = false

onready var gameManager = get_node("/root/GameManager")

func _on_BodyPartSlot_body_entered(body):
	if (!body.inSlot):
		populatedMonsterTypeId = body.monsterTypeId
		populatedBodyPartId = body.bodyPartId
		populated = true
		body.inSlot = true
		self.get_node("Sprite").set_texture(load("res://Assets/slots/slot-populated.png"))
		get_node("click").play()
		
		if groupDone(getRightGroup(self.get_groups())):
			print("won")

func _on_BodyPartSlot_body_exited(body):
	populatedMonsterTypeId = 0
	populatedBodyPartId = 0
	populated = false
	body.inSlot = false
	self.get_node("Sprite").set_texture(load("res://Assets/slots/slot.png"))
	
func groupDone(groupName):
	var slots = get_tree().get_nodes_in_group(groupName)
	if allSlotsPopulated(slots):
		for order in gameManager.getOrders():
			if isOrderDone(order, slots):
				return true
	return false

func getRightGroup(groups):
	for group in groups:
		if not "root" in group:
			return group

func allSlotsPopulated(slots):
	var count = 0
	for slot in slots:
		if slot.populated:
			count = count + 1
	return count == slots.size()

func isOrderDone(order, slots):
	var count = 0
	for monsterPart in order.monsterParts:
		for slot in slots:
			if monsterPart.getMonster() == slot.populatedMonsterTypeId || monsterPart.getBodyPart() == slot.populatedBodyPartId:
				count = count + 1
				break

	return count == order.monsterParts.size();