extends Node2D

var coffeMachine: Area2D
var coffeIsDone

# Called when the node enters the scene tree for the first time.
func _ready():
	coffeMachine = $coffee_machine
	coffeMachine.coffe_is_done.connect(coffe_done)

func _unhandled_input(event):
	#if bool set, make it able to change scene
	if(event.is_action_pressed("Action") && coffeIsDone):
		coffeIsDone = false
		get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn")
func coffe_done():
	coffeIsDone = true
