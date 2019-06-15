extends RigidBody2D

var bodyPartId: int
var monsterTypeId: int
var held = false

signal clicked

func _process(delta):
	if held:
        global_transform.origin = get_global_mouse_position()

func pickup():
    if held:
        return
    mode = RigidBody2D.MODE_STATIC
    held = true

func drop(impulse=Vector2.ZERO):
    if held:
        mode = RigidBody2D.MODE_RIGID
        held = false

func _on_BodyPart_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            emit_signal("clicked", self)