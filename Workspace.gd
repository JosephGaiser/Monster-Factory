extends Node

var held_object = null
var spawnRate = 10
var orderRate = 3
var currentSpawnTime = 0
var currentOrderTime = 0
var orders: Array

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
	
	if (currentSpawnTime > spawnRate):
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
	
	if (currentOrderTime > orderRate):
		currentOrderTime = 0
		var order = Order.new()
		order.points = 500
		randomize()
		for i in range(1,3):
			randomize()
			var monsterPart = MonsterPart.new()
			monsterPart.monsterTypeId = range(1,4)[randi()%range(1,4).size()]
			monsterPart.bodyPartId = i
			order.monsterParts.push_front(monsterPart)
			
		orders.push_front(order)
		
class Order:
	var monsterParts: Array
	var points: int
	
class MonsterPart:
	var monsterTypeId: int
	var bodyPartId: int