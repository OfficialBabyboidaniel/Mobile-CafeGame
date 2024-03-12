extends Control

@onready var audio_player = $AudioStreamPlayer


func _on_play_pressed() -> void:
	audio_player.play()
	await audio_player.finished
	get_tree().change_scene_to_file("res://Scenes & Scripts/Levels/main_level.tscn")


func _on_options_pressed() -> void:
	audio_player.play()
	await audio_player.finished
	get_tree().change_scene_to_file("res://Scenes & Scripts/UI/Menu/options_menu.tscn")
