extends RigidBody2D

var monsterTypeId: int
var bodyPartId = 1

var held = false

signal clicked

func _ready():
	match bodyPartId:
		1:
			get_node("Sprite").play("skeleton-head")
		2:
			get_node("Sprite").play("skeleton-torso")
		3:
			get_node("Sprite").play("skeleton-leg")
			

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
		add_force(global_position, Vector2.ZERO)
		held = false

func _on_BodyPart_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            emit_signal("clicked", self)