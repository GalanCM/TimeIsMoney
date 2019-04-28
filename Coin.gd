extends Sprite

func _ready() -> void:
	hide()
	
	yield( get_tree().create_timer(randf()), "timeout")
	$SpinPlayer.play("Spin")
	show()