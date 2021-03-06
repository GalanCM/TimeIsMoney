extends StaticBody2D

export var hits := 1
export var value := 1

var hits_taken := 0

var break_player : AudioStreamPlayer2D

func add_income():
	var profit := ( get_tree().get_nodes_in_group("Profit")[0] as Profit )
	if profit:
		profit.rpc("new_income", value)
	
	var stats_node = get_tree().get_nodes_in_group("Stats")[0]
	if stats_node:
		stats_node.earnings += value
		
	break_player = $BreakPlayer
	remove_child($BreakPlayer)

func take_hit():
	hits_taken += 1
	if hits - hits_taken <= 0:
		queue_free()
	else:
		$AnimationPlayer.play("flash")
		
func queue_free():
	add_income()
	
	get_tree().get_nodes_in_group("GameScene")[0].add_child(break_player)
	
	for i in range(value):
		var coin = preload("res://Coin.tscn").instance()
		coin.global_position.x += global_position.x  + i / 2 * (-3 if i % 2 == 1 else 3)
		coin.global_position.y = global_position.y
		get_tree().get_nodes_in_group("GameScene")[0].add_child(coin)
		
	break_player.play()
	
	.queue_free()