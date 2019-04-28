extends StaticBody2D

export var hits := 1
export var value := 1

var hits_taken := 0

func add_income():
	var profit := ( get_tree().get_nodes_in_group("Profit")[0] as Profit )
	if profit:
		profit.rpc("new_income", value)
	
	var stats_node = get_tree().get_nodes_in_group("Stats")[0]
	if stats_node:
		stats_node.earnings += value

func take_hit():
	hits_taken += 1
	if hits - hits_taken <= 1:
		queue_free()
		
func queue_free():
	add_income()
	.queue_free()