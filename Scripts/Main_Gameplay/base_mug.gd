extends Area2D


var selected = false
var inCoffeMachine = false
var in_rest_zone = false
var is_processing_enabled : bool = true

#current rest point and available rest nodes
var rest_point
var rest_nodes = []


#get rest_nodes and set rest point to first node in tree
func _ready(): 
	rest_nodes = get_tree().get_nodes_in_group("zone")
	if rest_nodes.size() > 0:
		rest_point = rest_nodes[0].global_position
		for child in rest_nodes:
			rest_point = child.global_position
			child.object_entered_rest_zone.connect(item_entered_rest_zone)
			child.object_left_rest_zone.connect(item_left_rest_zone)

#check if mug is being held and move it wtih lerp. Move it back to its starting position if mug has been released
func _process(delta):
	if Input.is_action_pressed("Action") and selected and is_processing_enabled:
		global_position = lerp(global_position, get_global_mouse_position(), 100 * delta)
	else:
		selected = false
		if in_rest_zone and rest_point != null : 
			global_position = lerp(global_position, rest_point, 50 * delta)

func item_entered_rest_zone(self_zone, item):
		print("entered rest zone: ", self_zone)
		rest_point = self_zone.global_position
		print("restpoint pos: ", rest_point)
		in_rest_zone = true;

func item_left_rest_zone():
		print("left rest zone")
		rest_point = null
		in_rest_zone = false;

func _on_input_event(viewport, event, shape_idx):
	selected = true;

func set_selected(b_value):
	selected = b_value

func set_is_processing_enabled(b_value):
	is_processing_enabled = b_value
