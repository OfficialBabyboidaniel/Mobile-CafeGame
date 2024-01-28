extends Node

#AI customer
var AI_transform
@onready var AI_customer = preload("res://Scenes & Scripts/AI/ai_customer.tscn")
var spawn_timer: Timer


var has_made_coffe : bool = false

#HUD values
@export var money = 0
@export var gems = 0
@export var level = 1
@export var expererience = 0

func _ready():
	DialogManager.order_completed.connect(start_timer_to_create_new_customer)
	

#start timer to create a new customer
func start_timer_to_create_new_customer() -> void:
	spawn_timer = Timer.new()
	spawn_timer.wait_time = 2.0
	spawn_timer.one_shot = true
	add_child(spawn_timer)
	spawn_timer.connect("timeout", spawn_customer)
	# Start the timer
	spawn_timer.start()

func spawn_customer() -> void:
	var new_customer = AI_customer.instantiate()
	new_customer.transform = AI_transform
	get_tree().root.add_child(new_customer)


