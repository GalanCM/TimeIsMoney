extends Node2D

var backups = []

func _ready() -> void:
	for child in get_children():
		backups.append(child.duplicate())

func _process(delta: float) -> void:
	if get_child_count() == 0:
		for child in backups:
			add_child(child.duplicate())
