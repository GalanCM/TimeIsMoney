extends Panel
class_name Profit

signal profit_updated(amount)

sync var profit := 0 setget set_profit
sync var expenses := 0 setget set_expenses

var net_profit := 0

func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "sync_profit")

func sync_profit(id):
	if (is_network_master()):
		rset("profit", profit)
		rset("expenses", expenses)

func set_profit(value):
	profit = value
	$VBoxContainer/Profit/Money.text = "$" + str(value)
	get_tree().get_nodes_in_group("Lobby")[0].save_game()
	emit_signal("profit_updated", profit - expenses)
	update_net_profit()
	
func set_expenses(value):
	expenses = value
	get_tree().get_nodes_in_group("Lobby")[0].save_game()
	$VBoxContainer/Expenses/Money.text = "-$" + str(value)
	update_net_profit()
	
func update_net_profit():
	net_profit = profit - expenses
	$VBoxContainer/NetProfit/Money.text = "$" + str(net_profit)

remotesync func new_income(amount: int) -> void:
	self.profit += amount

remotesync func expense(amount: int) -> void:
	self.expenses += amount
	rset("expenses", expenses)