extends Node

var orders: Array
var points = 0

func createOrder():
	var order = Order.new()
	order.points = 500
	order.monsterParts.clear()

	randomize()
	for i in range(1,4):
		var monsterPart = MonsterPart.new()		
		monsterPart.monsterTypeId = range(1,4)[randi()%range(1,4).size()]
		monsterPart.bodyPartId = i
		print("order with body part " + String(monsterPart.bodyPartId))
		print("order with monster part " + String(monsterPart.monsterTypeId))
		
		order.monsterParts.push_front(monsterPart)
		
	orders.push_front(order)
	
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