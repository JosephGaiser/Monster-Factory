extends Area2D

var conveyerSpeed = -0.5

func _ready():
	var sprite = get_node("Sprite")
	sprite.play("Moving")

func _on_ConveyerBelt_body_entered(body):
	body.apply_central_impulse(Vector2(conveyerSpeed, 0))