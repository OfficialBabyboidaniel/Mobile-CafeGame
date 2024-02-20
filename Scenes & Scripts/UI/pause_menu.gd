extends Control


func _ready():
	$AnimationPlayer.play("RESET")


func _process(_delta):
	testEsc()


func resume():
	$PanelContainer/VBoxContainer/Resume.set_mouse_filter(MOUSE_FILTER_IGNORE)
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")


func pause():
	$PanelContainer/VBoxContainer/Resume.set_mouse_filter(MOUSE_FILTER_STOP)
	get_tree().paused = true
	$AnimationPlayer.play("blur")


func testEsc():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume()


func _on_resume_pressed() -> void:
	resume()
