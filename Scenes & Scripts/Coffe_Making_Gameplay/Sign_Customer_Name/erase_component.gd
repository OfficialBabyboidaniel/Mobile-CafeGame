extends Node2D

var erasing = false
var erasing_line = null

@export var erase_color: Color = Color("#2d2d2d")  # Define erase color variable


func _ready():
	erasing_line = Line2D.new()
	erasing_line.default_color = erase_color  # Use erase color variable
	add_child(erasing_line)


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
		erasing = true
		erasing_line = Line2D.new()
		erasing_line.default_color = erase_color  # Use erase color variable
		add_child(erasing_line)
		%name_signing_control.erased_line(self, erasing_line)
	elif (
		(event is InputEventScreenTouch and not event.pressed)
		or (event is InputEventMouseButton and not event.pressed)
	):
		erasing = false

	if (event is InputEventScreenDrag or event is InputEventMouseMotion) and erasing:
		erasing_line.add_point(mouse_pos_relative)  # Add point to erasing line


# # erase entire lines
# func _input(event):
# 	var mouse_pos_global

# 	if event is InputEventScreenTouch or event is InputEventScreenDrag:
# 		mouse_pos_global = event.position  # Get touch position
# 	elif event is InputEventMouseButton or event is InputEventMouseMotion:
# 		mouse_pos_global = get_global_mouse_position()  # Get mouse position

# 	var mouse_pos_relative = mouse_pos_global - get_global_position()  # Calculate position relative to this node

# 	if (
# 		(event is InputEventScreenTouch and event.pressed)
# 		or (event is InputEventMouseButton and event.pressed)
# 	):
# 		erasing = true
# 	elif (
# 		(event is InputEventScreenTouch and not event.pressed)
# 		or (event is InputEventMouseButton and not event.pressed)
# 	):
# 		erasing = false

# 	if (event is InputEventScreenDrag or event is InputEventMouseMotion) and erasing:
# 		erase_line(mouse_pos_relative)  # Use relative position


func erase_line(line_position):
	for child in %draw_component.get_children():
		if child is Line2D:
			var local_position = line_position - child.position
			for point in child.points:
				if point.distance_to(local_position) < 10:
					child.queue_free()
					break


func distance_to_segment(p, v, w):
	var l2 = v.distance_squared_to(w)
	if l2 == 0.0:
		return p.distance_to(v)
	var t = ((p.x - v.x) * (w.x - v.x) + (p.y - v.y) * (w.y - v.y)) / l2
	t = max(0, min(1, t))
	var projection = v.lerp(w, t)  # Use lerp instead of linear_interpolate
	return p.distance_to(projection)
