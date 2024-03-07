extends Node2D

var drawing: bool = false
var line: Line2D

func _process(_delta):
    if Input.is_action_just_pressed("Action"):
        drawing = true
        line = Line2D.new()
        add_child(line)
        line.add_point(get_global_mouse_position())
    elif Input.is_action_just_released("Action"):
        drawing = false

    if Input.is_action_pressed("Action") and drawing:
        line.add_point(get_global_mouse_position())


#create clear function

