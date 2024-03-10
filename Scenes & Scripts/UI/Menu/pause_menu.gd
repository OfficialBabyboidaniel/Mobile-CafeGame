extends Control


func _ready():
	disable_all_drawing_tools()
	%draw_component.set_process_input(true)


func _on_pen_pressed() -> void:
	disable_all_drawing_tools()
	%draw_component.set_process_input(true)


func disable_all_drawing_tools() -> void:
	for drawing_tool in get_tree().get_nodes_in_group("drawing_tools"):
		drawing_tool.set_process_input(false)


func _on_erase_pressed() -> void:
	disable_all_drawing_tools()
	%erase_component.set_process_input(true)
