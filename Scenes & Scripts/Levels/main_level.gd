extends Node2D
# Called when the node enters the scene tree for the first time.


func _ready():
	GlobalSingleton.set_AI_transform($AI_Customer.global_transform)

	DialogManager.conversation_finished.connect(_change_scene)
	#"add level manager for creation of new customrs in main level", add new AI customer here.


func _change_scene():
	get_tree().change_scene_to_file("res://Scenes & Scripts/Levels/coffe_making_level.tscn")
