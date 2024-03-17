extends CanvasLayer
class_name HUD

#labels for HUD
var money_label
var gems_label
var level_label

#switch values for sub-menus
var SETTINGS_MENU = 1
var SHOP_MENU = 2
var ACHIVEMENTS_MENU = 3


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


func _on_settings_pressed() -> void:
	open_pause_menu(find_pause_node(), SETTINGS_MENU)


func _on_money_pressed() -> void:
	open_pause_menu(find_pause_node(), SHOP_MENU)


func _on_achievements_pressed() -> void:
	open_pause_menu(find_pause_node(), ACHIVEMENTS_MENU)


func _on_gems_pressed() -> void:
	open_pause_menu(find_pause_node(), SHOP_MENU)


func open_pause_menu(pause_menu_child, menu) -> void:
	# Validate pause menu child node
	if is_instance_valid(pause_menu_child):
		#pause game and hide all menus
		pause_menu_child.hide_all_menus()
		pause_menu_child.pause()

		match menu:
			1:
				pause_menu_child._on_settings_pressed()
			2:
				pause_menu_child._on_shop_pressed()
			3:
				pause_menu_child._on_achievements_pressed()

	else:
		print("Pause menu child node not found!")


func find_pause_node():
	var tree = get_tree()
	print(tree)
	# Find pause menu node
	var pause_menu_instance = tree.get_first_node_in_group("pause_menu")
	var pause_menu_child = pause_menu_instance.get_node("PauseMenu")
	return pause_menu_child


func _on_recipes_pressed() -> void:
	if !$Control/MarginContainer/MarginContainer.is_visible():
		$Control/MarginContainer/MarginContainer.set_visible(true)
	else:
		$Control/MarginContainer/MarginContainer.set_visible(false)


func _on_back_pressed() -> void:
	$Control/MarginContainer/MarginContainer.set_visible(false)
