extends Node

var orders: Array
var points = 0

func createOrder():
	var order = Order.new()
	order.points = 500
	order.monsterParts.clear()

	for i in range(1,4):
		var monsterPart = MonsterPart.new()
		randomize()
		monsterPart.monsterTypeId = randi() % 4
		monsterPart.bodyPartId = i
		print("order with body part " + String(monsterPart.bodyPartId))
		print("order with monster part " + String(monsterPart.monsterTypeId))
		
		order.monsterParts.push_back(monsterPart)
		
	orders.push_back(order)
	
func getOrders():
	return orders
	
func removeOrder(order):
	orders.erase(order)
	
func addPoints(toAdd):
	points += toAdd	

class Order:
	var monsterParts: Array
	var points: int
	
class MonsterPart:
	var monsterTypeId: int
	var bodyPartId: int