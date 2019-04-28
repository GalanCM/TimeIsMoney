extends Node2D

signal buy(cost)

export var value = 100
export var reward_name = ""

var children := []
var active = false

func _init():
	hide()

func _ready():
	children = get_children()
	for child in children:
		remove_child(child)
	
	get_tree().connect("network_peer_connected", self, "restore_on_connect")
	
	var profit_node : Profit = get_tree().get_nodes_in_group("Profit")[0]
	profit_node.connect("profit_updated", self, "buy")
	connect("buy", profit_node, "expense")
	
func restore_on_connect(id):
	if active:
		rpc("restore")
		
sync func restore():
	active = true
	show()
	for child in children:
		add_child(child)
		
func buy(profit):
	if active == false and profit >= value:
		rpc("restore")
		get_tree().get_nodes_in_group("Lobby")[0].rewards.append(reward_name)
		emit_signal("buy", value)