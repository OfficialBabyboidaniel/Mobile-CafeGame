extends Area2D

var has_mug
var rest_zone
var timer : Timer
var coffe_filled : bool = false

signal coffe_is_done()
# Called when the node enters the scene tree for the first time.
func _ready():
	has_mug = false
	timer =  $Timer
	rest_zone = $rest_zone
	rest_zone.rested.connect(addCoffeMug)
	#rest_zone.un_rested.connect(removeCoffeMug)

func addCoffeMug():
	if not has_mug:
		has_mug = true
		
	# what if it has a mug

func removeCoffeMug():
	if has_mug:
		print("timer stopped")
		has_mug = false
		timer.stop()


func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and has_mug and timer.time_left <= 0 and !coffe_filled:
		timer.start()
		print(timer.time_left)
		print("timer started")
		

func _on_timer_timeout():
	timer.stop()
	coffe_filled = true;
	coffe_is_done.emit()
	print("coffe filleed")

