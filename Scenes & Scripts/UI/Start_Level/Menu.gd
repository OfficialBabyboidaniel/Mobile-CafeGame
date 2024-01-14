extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes & Scripts/Levels/main_level.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes & Scripts/UI/Options_menu.tscn")
