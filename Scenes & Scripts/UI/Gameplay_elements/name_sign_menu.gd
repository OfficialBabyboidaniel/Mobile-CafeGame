extends Control


func _on_clear_pressed() -> void:
	for child in %draw_component.get_children():
		child.queue_free()


func _on_finish_pressed() -> void:
	%name_signing_control.set_visible(false)
