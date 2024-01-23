class_name HUD
extends CanvasLayer

@onready var money_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Money
@onready var gems_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Gems
@onready var level_label = $Control/MarginContainer/VBoxContainer/HBoxContainer/Level

var expererience = 0
var money = 0:
	set(new_money):
		money = new_money
		update_money_label()
var gems = 0:
	set(new_gems):
		gems = new_gems
		update_gems_label()
var level = 0:
	set(new_level):
		level = new_level
		update_level_label()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_money_label()
	update_gems_label()
	update_level_label()
	DialogManager.order_completed.connect(add_currency_after_completed_order)


func add_currency_after_completed_order():
	money += 10
	gems += 1
	expererience += 5
	if expererience > 10:
		expererience = 0
		level += 1

func update_money_label():
	money_label.text = "Money: " + str(money)
func update_gems_label():
	gems_label.text = "Gems: " + str(money)
func update_level_label():
	level_label.text = "level: " + str(money)
