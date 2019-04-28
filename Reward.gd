extends CenterContainer

func announce(name):
	$Label.text = "As a thanks for the players' hard work\n A reward:  " + name
	$AnimationPlayer.play("Unveil")
	$AudioStreamPlayer.play()