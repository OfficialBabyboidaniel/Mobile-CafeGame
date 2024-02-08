extends Node
var spawn_timer: Timer

@onready var AI_customer = preload("res://Scenes & Scripts/AI/ai_customer.tscn")
#AI customer
@export var AI_transform_pos_x = 0
@export var AI_transform_pos_y = 0
@export var AI_transform_scale_x: float = 0
@export var AI_transform_scale_y: float = 0

var has_made_coffe: bool = false

#HUD values
@export var money = 0
@export var gems = 0
@export var level = 1
@export var expererience = 0


func _ready():
	print("global singelton ready being called")
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
	new_customer.position.x = AI_transform_pos_x
	new_customer.position.y = AI_transform_pos_y
	new_customer.scale.x = AI_transform_scale_x
	new_customer.scale.y = AI_transform_scale_y
	get_tree().root.add_child(new_customer)

# func save():
# 	print("saving global variables")
# 	var save_dict = {
# 		"filename" : get_scene_file_path(),
# 		"parent" : get_parent().get_path(),
# 		"pos_x" : self.position.x,
# 		"pos_y" : self.position.y,
# 		"money" : money,
# 		"gems" : gems,
# 		"level" : level,
# 		"expererience" : expererience,
# 		"AI_transform_pos_x" : AI_transform_pos_x,
# 		"AI_transform_pos_y" : AI_transform_pos_y,
# 		"AI_transform_scale_x" : AI_transform_scale_x,
# 		"AI_transform_scale_y" : AI_transform_scale_y
# 	}
# 	return save_dict
