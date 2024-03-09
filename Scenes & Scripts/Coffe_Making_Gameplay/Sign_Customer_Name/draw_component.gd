extends Node2D

var drawing: bool = false
var line: Line2D
var was_outside: bool = true


func _process(_delta):
	var mouse_pos_global = get_global_mouse_position()  # Get global mouse position
	var parent_global_pos = get_parent().get_global_position()  # Get parent's global position
	var mouse_pos_relative = mouse_pos_global - parent_global_pos  # Calculate mouse position relative to parent
	var parent_rect = get_parent().get_rect()  # Get parent's local rectangle

	if parent_rect.has_point(mouse_pos_relative):  # Check if relative mouse position is within parent's rectangle
		if Input.is_action_just_pressed("Action"):
			drawing = true
			line = Line2D.new()
			get_parent().add_child(line)
			line.add_point(mouse_pos_relative)  # Use relative mouse position
		elif Input.is_action_just_released("Action"):
			drawing = false
			line = null

		if Input.is_action_pressed("Action") and drawing and line != null:
			line.add_point(mouse_pos_relative)  # Use relative mouse position
	else:
		drawing = false
		line = null
