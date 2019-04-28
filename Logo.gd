extends Node2D

const SERVER_PORT = 9000
const SERVER_IP = "127.0.0.1"

func _ready() -> void:
	if not "--server" in OS.get_cmdline_args():
		get_tree().connect("connected_to_server", self, "_connected_ok")
		connect_to_server()
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		get_tree().paused = false
		queue_free()

		
func connect_to_server():
	var peer := NetworkedMultiplayerENet.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)
	
	get_tree().get_nodes_in_group("Lobby")[0].connect("new_rewards", self, "update_rewards")
	
func update_rewards(rewards):
	for reward in rewards:
		var label = $"Rewards/Sample Label".duplicate()
		label.text = reward
		label.show()
		$Rewards.add_child(label)