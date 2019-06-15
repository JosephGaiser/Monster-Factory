extends Node

var held_object = null

func _ready():
	var pickableNodes = get_tree().get_nodes_in_group("pickable")
	for node in pickableNodes:
        node.connect("clicked", self, "_on_pickable_clicked")

func _on_pickable_clicked(object):
	if !held_object:
        held_object = object
        held_object.pickup()

func _unhandled_input(event):
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        if held_object and !event.pressed:
            held_object.drop(Input.get_last_mouse_speed())
            held_object = null

func _on_Node_ready():
	pass # Replace with function body.
