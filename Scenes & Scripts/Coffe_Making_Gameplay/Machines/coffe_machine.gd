extends Area2D

var has_coffe_mug : bool = false
var holding_object_at_rest_zone : bool = false
var rest_zone
var timer : Timer
var coffe_filled : bool = false
var coffemug

signal coffe_is_done()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	has_coffe_mug = false
	coffe_filled = false
	timer =  $Timer
	rest_zone = $rest_zone
#	coffemug = get_tree().get_class()
	rest_zone.object_entered_rest_zone.connect(should_add_coffe_mug)

func should_add_coffe_mug(rest_zone, current_item):
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
		if(coffemug.is_in_group("CoffeMug")): #måste lägga till att de inte går att röra muggen här
			print("mug is of coffe mug")
			has_coffe_mug = true

func removeCoffeMug():
	if has_coffe_mug:
		print("timer stopped")
		has_coffe_mug = false
		timer.stop()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and has_coffe_mug and timer.time_left <= 0 and !coffe_filled:
		timer.start()
		print(timer.time_left)
		print("timer started")
		

func _on_timer_timeout():
	timer.stop()
	coffe_filled = true;
	coffe_is_done.emit()
	print("coffe filleed")

