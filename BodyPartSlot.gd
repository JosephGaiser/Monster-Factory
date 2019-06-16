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

		var group = getRightGroup(self.get_groups())
		if groupDone(group):
			var dock = getRightDock(get_tree().get_nodes_in_group(group))
			handleWin(dock)

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
				gameManager.points += order.bountyPoints;
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
	print("order done? " + String(slots.size())) 
	for monsterPart in order.monsterParts:
		for slot in slots:
			print("order parts " + " body " + String(monsterPart.monsterTypeId) + " part " + String(monsterPart.bodyPartId))
			print("slot parts " + " body " + String(slot.populatedBodyPartId) + " part " + String(slot.populatedMonsterTypeId))
			if monsterPart.monsterTypeId == slot.populatedMonsterTypeId && monsterPart.bodyPartId == slot.populatedBodyPartId:
				count = count + 1
				break

	return count == order.monsterParts.size();
	
func getRightDock(nodes):
	for node in nodes:
		if node.get_class() == "AnimatedSprite":
			return node
	
func handleWin(dock):
	dock.play("Finished")
	dock.get_node("Finished").play()
	