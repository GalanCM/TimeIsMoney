extends Node2D

func new_ball():
	var paddle_position = get_tree().get_nodes_in_group("Paddle")[0].position
	
	var new_ball = preload("res://Ball.tscn").instance()
	new_ball.position = Vector2(paddle_position.x, 750)
	add_child(new_ball)
