extends Node

var held_object = null
var spawnRate = 5
var orderRate = 12
var currentSpawnTime = 0
var currentOrderTime = 0

var ordersDelay = 2
var spawnDelay = 5
var currentOrdersDelay = 0
var currentSpawnDelay = 0
var orders: Array

onready var gameManager = get_node("/root/GameManager")

const bodyPart = preload("res://BodyPart.tscn")
	
func _process(delta):
	createPart(delta)
	createOrder(delta)

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
	currentSpawnDelay += delta
	
	if (currentSpawnTime > spawnRate && currentSpawnDelay > spawnDelay):
		currentSpawnTime = 0
		var part = bodyPart.instance()
		randomize()
		part.bodyPartId = range(1,4)[randi()%range(1,4).size()]
		randomize()
		part.monsterTypeId = range(1,4)[randi()%range(1,4).size()]
		part.connect("clicked", self, "_on_pickable_clicked")
		$PartsSpawn.add_child(part)
		
func createOrder(delta):
	currentOrderTime += delta
	currentOrdersDelay += delta
	
	if (currentOrderTime > orderRate && currentOrdersDelay > ordersDelay):
		currentOrderTime = 0
		gameManager.createOrder()
		
