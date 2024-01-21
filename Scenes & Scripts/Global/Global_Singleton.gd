class_name global_singleton
extends Node

var has_made_coffe : bool = false

@onready var AI_customer = preload("res://Scenes & Scripts/AI/ai_customer.tscn")
var spawn_timer: Timer

func _ready():
	DialogManager.order_completed.connect(start_timer_to_create_new_customer)
	spawn_timer.wait_time = 2.0
	spawn_timer.one_shot = true

#start timer to create a new customer
func start_timer_to_create_new_customer() -> void:
	spawn_timer = Timer.new()
	add_child(spawn_timer)
	spawn_timer.connect("timeout", spawn_customer)
	# Start the timer
	spawn_timer.start()
func spawn_customer() -> void:
	get_tree().root.add_child(AI_customer.instantiate())

