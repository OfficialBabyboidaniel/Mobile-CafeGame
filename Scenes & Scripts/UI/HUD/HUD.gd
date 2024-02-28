class_name HUD
extends CanvasLayer

var money_label
var gems_label
var level_label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money_label = $Control/MarginContainer/VBoxContainer2/HBoxContainer2/Money
	gems_label = $Control/MarginContainer/VBoxContainer2/HBoxContainer2/Gems
	level_label = $Control/MarginContainer/VBoxContainer1/HBoxContainer1/Level
	update_money_label()
	update_gems_label()
	update_level_label()
	DialogManager.order_completed.connect(add_currency_after_completed_order)


func add_currency_after_completed_order():
	GlobalSingleton.money += 10
	GlobalSingleton.gems += 1
	GlobalSingleton.expererience += 5
	if GlobalSingleton.expererience > 10:
		GlobalSingleton.expererience = 0
		GlobalSingleton.level += 1
	update_money_label()
	update_gems_label()
	update_level_label()
	SaveSystem.save_game()


func update_money_label():
	money_label.text = "Money: " + str(GlobalSingleton.money)


func update_gems_label():
	gems_label.text = "Gems: " + str(GlobalSingleton.gems)


func update_level_label():
	level_label.text = "level: " + str(GlobalSingleton.level)


func _on_money_pressed() -> void:
	open_pause_menu(find_pause_node())


func _on_gems_pressed() -> void:
	open_pause_menu(find_pause_node())


func _on_settings_pressed() -> void:
	open_pause_menu(find_pause_node())


func _on_achievements_pressed() -> void:
	open_pause_menu(find_pause_node())


func open_pause_menu(pause_menu_child) -> void:
	# Validate pause menu child node
	if is_instance_valid(pause_menu_child):
		# Call a function inside it
		pause_menu_child.pause()
		# Replace "some_function" with the actual function name
	else:
		print("Pause menu child node not found!")


func find_pause_node():
	var tree = get_tree()
	print(tree)
	# Find pause menu node
	var pause_menu_instance = tree.get_first_node_in_group("pause_menu")
	var pause_menu_child = pause_menu_instance.get_node("PauseMenu")
	return pause_menu_child
