extends AudioStreamPlayer2D

func play(from_position = 0.0):
	.play(from_position)
	
	yield(self, "finished")
	queue_free()
