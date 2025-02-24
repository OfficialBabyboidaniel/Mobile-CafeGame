extends Node

#g� igenom och skriva kommentar vad som h�nder

# Called when the node enters the scene tree for the first time.
@onready var text_box_scene = preload("res://Scenes & Scripts/AI/Dialogue/text_box.tscn")

var dialog_lines
var current_line_index = 0

var text_box: TextBox
var text_box_position: Vector2

var is_dialog_active = false
var can_advance_line = false

signal conversation_finished
signal order_completed


func start_dialog(position: Vector2, lines):
	if is_dialog_active:
		return
	dialog_lines = lines
	text_box_position = position
	_show_text_box()
	is_dialog_active = true


func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialog_lines[current_line_index]["TESTAI"])
	can_advance_line = false


func _on_text_box_finished_displaying():
	can_advance_line = true



func _unhandled_input(event):
	# print("dialoge active? :" + str(is_dialog_active))
	# print("can advance line? :" + str(can_advance_line))
	if event.is_action_pressed("Action") && is_dialog_active && can_advance_line:
		# print("trying to advance convo")
		text_box.queue_free()
		current_line_index += 1
		if current_line_index >= dialog_lines.size() && !GlobalSingleton.has_made_coffe:
			conversation_finished.emit()
			GlobalSingleton.has_made_coffe = true
			# print("consversation signal emittad")
			is_dialog_active = false
			current_line_index = 0
			return
		if current_line_index >= dialog_lines.size() && GlobalSingleton.has_made_coffe:
			GlobalSingleton.has_made_coffe = false
			order_completed.emit()
			is_dialog_active = false
			current_line_index = 0
			return

		_show_text_box()
