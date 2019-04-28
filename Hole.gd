extends Area2D

func _ready() -> void:
	connect("body_entered", self, "hole")

func hole(body) -> void:
	if body is Ball:
		body.queue_free()
		$HolePlayer.play()
		$HoleAnimation/AnimationPlayer.play("Hole")