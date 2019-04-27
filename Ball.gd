extends KinematicBody2D

onready var velocity := Vector2(rand_range(-200, 200), 500)

func _physics_process(delta: float) -> void:
	var ball_collision := move_and_collide(velocity * delta)
	
	if ball_collision != null:
		velocity = velocity.bounce(ball_collision.normal)
		
		if ball_collision.collider.has_method("add_income"):
			ball_collision.collider.add_income()

	velocity *= 1 + 0.02 * delta