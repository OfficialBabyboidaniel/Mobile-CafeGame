extends Node

var has_made_coffe : bool = false

@onready var AI_customer = preload("res://Scenes/AI/ai_customer.tscn")
var spawn_timer: Timer

func _ready():
	DialogManager.order_completed.connect(start_timer_to_create_new_custom)
	#Current_AI.customer_recieved_order.connect(start_timer_to_create_new_custom)


func start_timer_to_create_new_custom():
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.wait_time = 2.0  # Set the wait time to 3 seconds
	spawn_timer.one_shot = true  # Set the timer to trigger only once
	spawn_timer.connect("timeout", spawn_customer)
	# Start the timer
	spawn_timer.start()
func spawn_customer():
	get_tree().root.add_child(AI_customer.instantiate())
	

