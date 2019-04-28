extends KinematicBody2D


func _physics_process(delta: float) -> void:
	var move : Vector2
	
	move.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
	move.x *= 750 * delta
	
	move_and_collide(move) 
