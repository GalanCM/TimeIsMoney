extends KinematicBody2D
class_name Ball

signal ball_lost

export var cost = 50

var velocity : Vector2

func _ready() -> void:
	var direction = Vector2(rand_range(-1,1), rand_range(-1,0))
	velocity = direction.normalized() * 300
	
	var game_scene = get_tree().get_nodes_in_group("GameScene")[0]
	var profit = get_tree().get_nodes_in_group("Profit")[0]
	connect("ball_lost", game_scene, "new_ball")
	connect("ball_lost", profit, "expense", [cost])

func _physics_process(delta: float) -> void:
	move_and_slide(velocity)
	
	var ball_collision := get_slide_collision( get_slide_count() - 1 )
	if ball_collision != null:
		velocity = velocity.bounce(ball_collision.normal)
		
		if ball_collision.collider.has_method("take_hit"):
			ball_collision.collider.take_hit()
		velocity *= 1.01

	velocity *= 1 + 0.02 * delta
	
	$Sprite.rotate( velocity.length() / 50 * delta * (1 if velocity.x > 0 else -1) )
	
	if position.y > get_viewport_rect().size.y:
		queue_free()
		
func queue_free():
	emit_signal("ball_lost")
	.queue_free()