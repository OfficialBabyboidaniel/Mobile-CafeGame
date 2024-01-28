class_name HUD
extends CanvasLayer

var money_label 
var gems_label 
var level_label 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	money_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Money
	gems_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Gems
	level_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Level
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

func update_money_label():
	money_label.text = "Money: " + str(GlobalSingleton.money)
func update_gems_label():
	gems_label.text = "Gems: " + str(GlobalSingleton.gems)
func update_level_label():
	level_label.text = "level: " + str(GlobalSingleton.level)
