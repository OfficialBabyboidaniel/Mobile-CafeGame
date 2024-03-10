extends Node2D

var drawing: bool = false
var line: Line2D
var was_outside: bool = true


func _input(event):
	var mouse_pos_global

	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		mouse_pos_global = event.position  # Get touch position
	elif event is InputEventMouseButton or event is InputEventMouseMotion:
		mouse_pos_global = get_global_mouse_position()  # Get mouse position

	var mouse_pos_relative = mouse_pos_global - get_global_position()  # Calculate position relative to this node

	if (
		(event is InputEventScreenTouch and event.pressed)
		or (event is InputEventMouseButton and event.pressed)
	):
		drawing = true
		line = Line2D.new()
		add_child(line)
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
