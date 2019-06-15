extends Sprite

var mouse_in = false
var dragging = false
var inContainer = false

var bodyPartId: int
var monsterTypeId: int

func _process(delta):
	if mouse_in && Input.is_action_pressed("left_click"):
		dragging = true
		
	if dragging && Input.is_action_pressed("left_click"):
		position = get_viewport().get_mouse_position()
		
	else:
		dragging = false
		if inContainer:
			print("it's in")

func _on_Area2D_mouse_entered():
	mouse_in = true

func _on_Area2D_mouse_exited():
	mouse_in = false

func _on_Area2D_area_entered(area):
	var areas = area.get_overlapping_areas()
	for area in areas:
		if area.name == "BodyPartArea":
			inContainer = true
			print("collided with player")


func _on_BodyPartArea_area_exited(area):
	inContainer = false
