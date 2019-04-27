extends Panel

var earnings := 0 setget set_earnings
var play_time := 0 setget set_play_time

func _ready() -> void:
	$PlayTimer.connect("timeout", self, "add_second")
	play_time = 0
	
	var save_game = File.new()
	if save_game.file_exists("user://player.save"):
		save_game.open("user://player.save", File.READ)
		self.earnings = save_game.get_64()
		self.play_time = save_game.get_64()
		save_game.close()

func set_earnings(amount):
	earnings = amount
	$VBoxContainer/RevenueEarned/Value.text = "$ " + str(earnings)
	set_rate()
	
func set_play_time(amount):
	play_time = amount
	var hours = play_time / 3600
	var minutes = play_time % 3600 / 60
	var seconds = (play_time % 3600) % 60
	$VBoxContainer/Time/Value.text = str(hours) + ":" + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	set_rate()

func set_rate():
	if play_time > 0:
		$VBoxContainer/RevenuePerHour/Value.text = "$ " + str( float(earnings) / (float(play_time) / 3600) ).pad_decimals(2) + " / hour" 
	
	var save_game = File.new()
	save_game.open("user://player.save", File.WRITE)
	save_game.store_64(earnings)
	save_game.store_64(play_time)
	save_game.close()

func add_second():
	self.play_time += 1