extends Node2D

var erasing: bool = false


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
			erasing = true
		elif (
			(event is InputEventScreenTouch and not event.pressed)
			or (event is InputEventMouseButton and not event.pressed)
		):
			erasing = false

		if (event is InputEventScreenDrag or event is InputEventMouseMotion) and erasing:
			erase_line(mouse_pos_relative)  # Use relative position


func erase_line(line_position):
	for child in get_parent().get_children():
		if child is Line2D:
			var local_position = child.global_transform.affine_inverse().xform(line_position)  # Convert to local space
			var points = child.get_points()
			for i in range(points.size() - 1):
				var point1 = points[i]
				var point2 = points[i + 1]
				var distance = distance_to_segment(local_position, point1, point2)
				if distance < 10:  # Check if the point is within a 10 pixel radius of the line segment
					child.queue_free()  # Free the line
					break


func distance_to_segment(p, v, w):
	var l2 = v.distance_squared_to(w)
	if l2 == 0.0:
		return p.distance_to(v)
	var t = ((p.x - v.x) * (w.x - v.x) + (p.y - v.y) * (w.y - v.y)) / l2
	t = max(0, min(1, t))
	var projection = v.linear_interpolate(w, t)
	return p.distance_to(projection)
