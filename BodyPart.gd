extends RigidBody2D

var monsterTypeId: int
var bodyPartId: int
var inSlot = false
var held = false

signal clicked

func _ready():
	var animationName = ""
	match monsterTypeId:
		1:
			animationName += "skeleton-"
		2:
			animationName += "goblin-"
		3:
			animationName += "squid-"
			
	match bodyPartId:
		1:
			animationName += "head"
		2:
			animationName += "torso"
		3:
			animationName += "leg"
			
	get_node("Sprite").play(animationName)

func _process(delta):
	if held:
        global_transform.origin = get_global_mouse_position()

func pickup():
    if held:
        return
    mode = RigidBody2D.MODE_STATIC
    held = true

func drop():
	if held:
		mode = RigidBody2D.MODE_RIGID
		add_force(global_position, Vector2.ZERO)
		held = false

func _on_BodyPart_input_event(viewport, event, shape_idx):
	print("adsadadasdsd")
	if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.pressed:
            emit_signal("clicked", self)