extends CanvasLayer

var SETTINGS_MENU = 1
var SHOP_MENU = 2


@onready var audio_player = $AudioStreamPlayer


func _on_play_pressed() -> void:
	audio_player.play()
	await audio_player.finished
	get_tree().change_scene_to_file("res://Scenes & Scripts/Levels/main_level.tscn")




func _on_shop_pressed():
	audio_player.play()
	await audio_player.finished
	open_pause_menu(find_pause_node(), SHOP_MENU)

func _on_options_pressed():
	audio_player.play()
	await audio_player.finished
	open_pause_menu(find_pause_node(), SETTINGS_MENU)
	 # Replace with function body.

func open_pause_menu(pause_menu_child, menu) -> void:
	# Validate pause menu child node
	if is_instance_valid(pause_menu_child):
		#pause game and hide all menus
		pause_menu_child.hide_all_menus()
		pause_menu_child.pause()

		match menu:
			1:
				pause_menu_child._on_settings_pressed()
			2:
				pause_menu_child._on_shop_pressed()

	else:
		print("Pause menu child node not found!")


func find_pause_node():
	var tree = get_tree()
	print(tree)
	# Find pause menu node
	var pause_menu_instance = tree.get_first_node_in_group("pause_menu")
	var pause_menu_child = pause_menu_instance.get_node("PauseMenu")
	return pause_menu_child
