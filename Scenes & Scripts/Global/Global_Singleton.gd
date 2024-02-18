extends Node
var spawn_timer: Timer

var AI_customer = preload("res://Scenes & Scripts/AI/ai_customer.tscn")
#AI customer
var AI_Transform
var b_AI_Transform_set: bool = false

var has_made_coffe: bool = false

#HUD values
var money = 0
var gems = 0
var level = 1
var expererience = 0

var has_initialized
var save_file_loaded: bool


func _ready():
	print("global singelton ready being called")
	#add level manager for creation of new customrs
	DialogManager.order_completed.connect(start_timer_to_create_new_customer)

	has_initialized = true


#start timer to create a new customer
func start_timer_to_create_new_customer() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 1.0
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	spawn_timer.connect("timeout", spawn_customer)
	# Start the timer
	spawn_timer.start()


func spawn_customer() -> void:
	var new_customer = AI_customer.instantiate()
	new_customer.global_transform = AI_Transform
	get_tree().root.add_child(new_customer)


func set_AI_transform(transform) -> void:
	if b_AI_Transform_set == false:
		print("Setting Ai transform first time, skould only print once")
		AI_Transform = transform
		b_AI_Transform_set = true
