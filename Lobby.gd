extends Node

const SERVER_PORT = 9000
const SERVER_IP = "127.0.0.1"
const MAX_PLAYERS = 20

signal new_rewards(rewards)

sync var rewards = [] setget set_rewards

func _ready():
	get_tree().paused = true
	
	if ("--server" in OS.get_cmdline_args()):
		var peer := NetworkedMultiplayerENet.new()
		peer.create_server(SERVER_PORT, MAX_PLAYERS)
		get_tree().set_network_peer(peer)
		get_tree().connect("network_peer_connected", self, "_player_connected")
		
		var profit_node : Node = get_tree().get_nodes_in_group("Profit")[0]
		var save_game = File.new()
		if save_game.file_exists("user://server.save"):
			save_game.open("user://server.save", File.READ)
			
			var profit = int(save_game.get_line())
			while profit > 0:
				profit_node.profit += 1
				profit -= 1
				
			save_game.close()
		$Logo.queue_free()
	
func _player_connected(id):
	if (is_network_master()):
		rset("rewards", rewards)
		
func set_rewards(value):
	rewards = value
	emit_signal("new_rewards", value)
	
	
func save_game():
	if is_network_master():
		var save_game = File.new()
		save_game.open("user://server.save", File.WRITE)
		
		var profit_node = get_tree().get_nodes_in_group("Profit")[0]
		save_game.store_line( str(profit_node.profit) )
		save_game.close()