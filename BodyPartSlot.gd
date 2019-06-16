extends Area2D

export var monsterTypeId: int
export var bodyPartId: int
var populatedMonsterTypeId: int
var populatedBodyPartId: int
var populated = false

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
		if not slot.populated:
			return false			
		if slot.populatedBodyPartId != slot.bodyPartId || slot.populatedMonsterTypeId != slot.monsterTypeId:
			return false
			
	return true
	
func getRightGroup(groups):
	for group in groups:
		if not "root" in group:
			return group