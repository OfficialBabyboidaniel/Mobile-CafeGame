extends Node2D

var drawing: bool = false
var line: Line2D
var was_outside: bool = true


func _input(event):
	var mouse_pos_global
	var parent_global_pos = get_parent().get_global_position()  # Get parent's global position
	var mouse_pos_relative
	var parent_rect = get_parent().get_rect()  # Get parent's local rectangle

	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		mouse_pos_global = event.position  # Get touch position
	elif event is InputEventMouseButton or event is InputEventMouseMotion:
		mouse_pos_global = get_global_mouse_position()  # Get mouse position

	mouse_pos_relative = mouse_pos_global - parent_global_pos  # Calculate position relative to parent

	if parent_rect.has_point(mouse_pos_relative):  # Check if relative position is within parent's rectangle
		if (
			(event is InputEventScreenTouch and event.pressed)
			or (event is InputEventMouseButton and event.pressed)
		):
			drawing = true
			line = Line2D.new()
			get_parent().add_child(line)
			line.add_point(mouse_pos_relative)  # Use relative position
		elif (
			(event is InputEventScreenTouch and not event.pressed)
			or (event is InputEventMouseButton and not event.pressed)
		):
			drawing = false
			line = null

		if (
			(event is InputEventScreenDrag or event is InputEventMouseMotion)
			and drawing
			and line != null
		):
			line.add_point(mouse_pos_relative)  # Use relative position
	else:
		drawing = false
		line = null
