extends Node

var held_object = null
var spawnRate = 3
var currentSpawnTime = 0

const bodyPart = preload("res://BodyPart.tscn")

func _ready():
	pass
	
func _process(delta):
	createPart(delta)

func _on_pickable_clicked(object):
	if !held_object:
        held_object = object
        held_object.pickup()

func _unhandled_input(event):
    if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
        if held_object and !event.pressed:
            held_object.drop()
            held_object = null

func createPart(delta):
	currentSpawnTime += delta
	
	if (currentSpawnTime > spawnRate):
		currentSpawnTime = 0
		var part = bodyPart.instance()
		part.bodyPartId = 1
		part.monsterTypeId = 1
		part.connect("clicked", self, "_on_pickable_clicked")
		$GridContainer.add_child(part)
