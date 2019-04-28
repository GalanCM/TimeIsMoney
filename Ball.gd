extends KinematicBody2D
class_name Ball

signal ball_lost

export var cost = 50

onready var velocity := Vector2(rand_range(-200, 200), rand_range(300, 500) * -1 if randi() % 2 == 0 else 1)

func _ready() -> void:
	var game_scene = get_tree().get_nodes_in_group("GameScene")[0]
	var profit = get_tree().get_nodes_in_group("Profit")[0]
	connect("ball_lost", game_scene, "new_ball")
	connect("ball_lost", profit, "expense", [cost])

func _physics_process(delta: float) -> void:
	var ball_collision := move_and_collide(velocity * delta)
	
	if ball_collision != null:
		velocity = velocity.bounce(ball_collision.normal)
		
		if ball_collision.collider.has_method("take_hit"):
			ball_collision.collider.take_hit()

	velocity *= 1 + 0.02 * delta
	
	if position.y > get_viewport_rect().size.y:
		queue_free()
		
func queue_free():
	print('qf')
	emit_signal("ball_lost")
	.queue_free()