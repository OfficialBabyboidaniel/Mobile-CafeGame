extends Control

@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")


func _ready():
	#$AnimationPlayer.play("RESET")
	pass


func _process(_delta):
	testEsc()


func resume():
	%PauseMenu.visible = false
	$SettingsContainer/VBoxContainer/Resume.set_mouse_filter(MOUSE_FILTER_IGNORE)
	get_tree().paused = false
	#$AnimationPlayer.play_backwards("blur")


func pause():
	%PauseMenu.visible = true
	$SettingsContainer/VBoxContainer/Resume.set_mouse_filter(MOUSE_FILTER_STOP)
	get_tree().paused = true
	#$AnimationPlayer.play("blur")


func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()


func _on_resume_pressed() -> void:
	resume()


#sub menu buttons
func _on_settings_pressed() -> void:
	hide_all_menus()
	%SettingsContainer.visible = true


func _on_shop_pressed() -> void:
	hide_all_menus()
	%ShopContainer.visible = true


func _on_achievements_pressed() -> void:
	hide_all_menus()
	%AchievementsContainer.visible = true


func _on_legal_pressed() -> void:
	hide_all_menus()
	%LegalContainer.visible = true


func hide_all_menus() -> void:
	# Get an array of all nodes in the "menus" group
	var menu_nodes = get_tree().get_nodes_in_group("menus")

	# Iterate through each node in the array
	for node in menu_nodes:
		# Check if the node is valid
		if is_instance_valid(node):
			# Make the node non-visible
			node.visible = false


func _on_music_slider_value_changed(value: float) -> void:
	print("chaning music slider")
	print("music BUS ID : " , MUSIC_BUS_ID)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)


func _on_sfx_slider_value_changed(value: float) -> void:
	print("chaning sfx slider")
	print("SFX BUS ID : " , SFX_BUS_ID)
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)
