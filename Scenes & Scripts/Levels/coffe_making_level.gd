extends Node2D

@onready var coffe_machine: coffe_machine = $coffee_machine
var coffe_is_finisished

#connect coffe machine signal to func 
func _ready():
	coffe_machine.coffe_is_done.connect(coffe_done)

#change scene if coffe is done
func _unhandled_input(event):
	if(event.is_action_pressed("Action") && coffe_is_finisished):
		coffe_is_finisished = false
		get_tree().change_scene_to_file("res://Scenes & Scripts/Levels/main_level.tscn")
func coffe_done():
	coffe_is_finisished = true
