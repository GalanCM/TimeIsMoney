extends Panel
class_name Profit

signal profit_updated(amount)

sync var profit := 0 setget set_profit
sync var expenses := 0 setget set_expenses


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
	
func set_expenses(value):
	expenses = value
	get_tree().get_nodes_in_group("Lobby")[0].save_game()
	$VBoxContainer/Expenses/Money.text = "-$" + str(value)

remotesync func new_income(amount: int) -> void:
	self.profit += amount

remotesync func expense(amount: int) -> void:
	self.expenses += amount