class_name coffe_machine
extends Area2D

var has_coffe_mug : bool = false
var coffe_filled : bool = false
var holding_object_at_rest_zone : bool = false

@onready var timer : Timer = $Timer
@onready var rest_zone_ref: rest_zone = $rest_zone #how to force this to be a rest zone class?
var coffemug: coffe_mug  #how to force this to be a coffe mug class? 

signal coffe_is_done()

# Called when the node enters the scene tree for the first time.
func _ready():
	rest_zone_ref.object_entered_rest_zone.connect(should_add_coffe_mug)

#check if it should add coffe_mug when an item enters coffe_machine rest zone
func should_add_coffe_mug(incoming_rest_zone, current_item):
	print("coffe muggelse : ", current_item)
	if(!is_instance_valid(current_item)):
		print("mug not valid returning")
		return 
	if not has_coffe_mug and current_item.is_in_group("CoffeMug"):
		holding_object_at_rest_zone = true
		coffemug = current_item

#Check if mug has been dropped in the rest zone
func _process(delta):
	if (holding_object_at_rest_zone == true and !Input.is_action_pressed("Action")):
		print("dropped mug at rest zone, setting variables")
		holding_object_at_rest_zone = false
		if(coffemug.is_in_group("CoffeMug")): 
			print("mug is of coffe mug")
			has_coffe_mug = true
			coffemug.get_node("dragging_component").set_is_processing_enabled(false)

#functionality when pressed on coffemachine
func _on_input_event(_viewport, event, _shape_idx):
	if Input.is_action_pressed("Action") and has_coffe_mug and timer.time_left <= 0 and !coffe_filled:
		timer.start()
		print(timer.time_left)
		print("timer started")

#when coffe timer finished
func _on_timer_timeout():
	timer.stop()
	coffe_filled = true;
	coffe_is_done.emit()
	print("coffe filleed")

