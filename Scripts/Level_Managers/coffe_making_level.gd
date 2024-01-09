extends Node2D

var coffe_machine: Area2D
var coffe_is_done

#connect coffe machine signal to func 
func _ready():
	coffe_machine = $coffee_machine
	coffe_machine.coffe_is_done.connect(coffe_done)

#change scene if coffe is done
func _unhandled_input(event):
	if(event.is_action_pressed("Action") && coffe_is_done):
		coffe_is_done = false
		get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")
func coffe_done():
	coffe_is_done = true
