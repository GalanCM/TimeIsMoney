extends CenterContainer

func announce(name):
	$Label.text = "As a thanks for the players' hard work\n We bought this for you: " + name +"!"
	$AnimationPlayer.play("Unveil")
	$AudioStreamPlayer.play()