extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/Levels/main_level.tscn") # Replace with function body.

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/UI/Options_menu.tscn")
