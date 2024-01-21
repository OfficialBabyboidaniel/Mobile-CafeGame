extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogManager.conversation_finished.connect(_change_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _change_scene():
	get_tree().change_scene_to_file("res://Scenes & Scripts/Levels/coffe_making_level.tscn")
