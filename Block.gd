extends StaticBody2D


func add_income():
	var profit := ( get_tree().get_nodes_in_group("Profit")[0] as Profit )
	if profit:
		profit.rpc("new_income", 100)
	
	var stats_node = get_tree().get_nodes_in_group("Stats")[0]
	if stats_node:
		stats_node.earnings += 100

