extends Area2D

func _ready():
	var sprite = get_node("Sprite")
	sprite.play("Moving")

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		print(body.name)
