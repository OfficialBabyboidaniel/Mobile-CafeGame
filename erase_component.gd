extends Node2D

var erasing: bool = false


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
	elif (
		(event is InputEventScreenTouch and not event.pressed)
		or (event is InputEventMouseButton and not event.pressed)
	):
		erasing = false

	if (event is InputEventScreenDrag or event is InputEventMouseMotion) and erasing:
		erase_line(mouse_pos_relative)  # Use relative position


# func _input(event):
# 	var mouse_pos_global
# 	var parent_global_pos = get_parent().get_global_position()  # Get parent's global position
# 	var mouse_pos_relative
# 	var parent_rect = get_parent().get_rect()  # Get parent's local rectangle

# 	if event is InputEventScreenTouch or event is InputEventScreenDrag:
# 		mouse_pos_global = event.position  # Get touch position
# 	elif event is InputEventMouseButton or event is InputEventMouseMotion:
# 		mouse_pos_global = get_global_mouse_position()  # Get mouse position

# 	mouse_pos_relative = mouse_pos_global - parent_global_pos  # Calculate position relative to parent

# 	if parent_rect.has_point(mouse_pos_relative):  # Check if relative position is within parent's rectangle
# 		if (
# 			(event is InputEventScreenTouch and event.pressed)
# 			or (event is InputEventMouseButton and event.pressed)
# 		):
# 			erasing = true
# 		elif (
# 			(event is InputEventScreenTouch and not event.pressed)
# 			or (event is InputEventMouseButton and not event.pressed)
# 		):
# 			erasing = false

# 		if (event is InputEventScreenDrag or event is InputEventMouseMotion) and erasing:
# 			erase_line(mouse_pos_relative)  # Use relative position


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
