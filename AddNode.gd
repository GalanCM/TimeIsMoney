extends Button

func _ready() -> void:
	connect("button_up", self, "create_and_sync_node")
	
func create_and_sync_node():
	rpc("add_godot", Vector2(rand_range(0, 1), rand_range(0,1)) )

remotesync func add_godot(position):
	var godot := preload("res://TestObject.tscn").instance()
	godot.position = position * get_viewport_rect().size
	get_node("/root").add_child(godot)