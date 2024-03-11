extends Control

var command_list = []
var command_index = -1


func _ready():
	disable_all_drawing_tools()
	%draw_component.set_process_input(true)


func _on_pen_pressed() -> void:
	disable_all_drawing_tools()
	%draw_component.set_process_input(true)


func _on_erase_pressed() -> void:
	disable_all_drawing_tools()
	%erase_component.set_process_input(true)


func _on_clear_pressed() -> void:
	var lines = []
	for child in %draw_component.get_children():
		lines.append(child)
		child.set_visible(false)
	for child in %erase_component.get_children():
		lines.append(child)
		child.set_visible(false)
	command_list.append({"action": "clear", "lines": lines})
	command_index += 1


func disable_all_drawing_tools() -> void:
	for drawing_tool in get_tree().get_nodes_in_group("drawing_tools"):
		drawing_tool.set_process_input(false)


#undo and redo functions


func start_line(parent, created_line):
	command_index += 1
	command_list = command_list.slice(0, command_index)  # Remove any undone commands
	command_list.append({"action": "start_line", "parent": parent, "line": created_line})


func erased_line(parent, line_erased):
	command_index += 1
	command_list.append({"action": "erased_line", "parent": parent, "line": line_erased})


func _on_undo_pressed() -> void:
	if command_index >= 0:
		command_index -= 1
		redraw_scene()  # Replace with function body.


func _on_redo_pressed() -> void:
	if command_index < len(command_list) - 1:
		command_index += 1
		redraw_scene()  # Replace with function body.


func redraw_scene():
	# Clear the scene
	for child in %draw_component.get_children():
		lines.append(child)
		child.set_visible(false)
	for child in %erase_component.get_children():
		lines.append(child)
		child.set_visible(false)

	# Redraw each command, does not work
	for i in range(command_index + 1):
		var command = command_list[i]
		if command["action"] == "start_line":
			if command["line"].get_parent() != null:
				command["line"].get_parent().remove_child(command["line"])
			command["parent"].add_child(command["line"])
		elif command["action"] == "erased_line":
			if command["line"].get_parent() != null:
				command["line"].get_parent().remove_child(command["line"])
			command["parent"].add_child(command["line"])
		elif command["action"] == "clear":
			for line in command["lines"]:
				if line.get_parent() != null:
					line.get_parent().remove_child(line)
				add_child(line)
				line.set_visible(true)
