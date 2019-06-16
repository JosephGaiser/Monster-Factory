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
	for slot in slots:
		var orderWithPart = getOrderWithPart(slot.populatedBodyPartId, slot.populatedMonsterTypeId)
		if orderWithPart == null:
			return false
		else:
			return isOrderDone(orderWithPart, slots)
		if not slot.populated:
			return false
		if slot.populatedBodyPartId != slot.bodyPartId || slot.populatedMonsterTypeId != slot.monsterTypeId:
			return false
			
	return false
	
func getRightGroup(groups):
	for group in groups:
		if not "root" in group:
			return group
			
func getOrderWithPart(bodyPart, monsterId):
	var orders = gameManager.getOrders()
	for order in orders:
		for parts in order.monsterParts:
			if parts.monsterTypeId == monsterId && parts.bodyPartId == bodyPart:
				return order
				
	return null
	
func isOrderDone(order, slots):
	for slot in slots:
		for monsterPart in order.monsterParts:
			if monsterPart.monsterTypeId != slot.populatedMonsterTypeId || monsterPart.bodyPartId != slot.populatedBodyPartId:
				return false;
				
	return true;