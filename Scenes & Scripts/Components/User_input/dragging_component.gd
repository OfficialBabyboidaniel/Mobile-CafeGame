extends Node2D

var selected = false
var in_rest_zone = false
var is_processing_enabled : bool = true

#current rest point and available rest nodes
var rest_point
var rest_nodes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	is_processing_enabled = true
	rest_nodes = get_tree().get_nodes_in_group("zone")
	if rest_nodes.size() > 0:
		rest_point = rest_nodes[0].global_position
		for child in rest_nodes:
			rest_point = child.global_position
			child.object_entered_rest_zone.connect(item_entered_rest_zone)
			child.object_left_rest_zone.connect(item_left_rest_zone)

#check if parent node is being held and move it wtih lerp. Move it back to its starting position if mug has been released
func _process(delta):
	if Input.is_action_pressed("Action") and selected and is_processing_enabled:
		if get_parent():
			get_parent().global_position = lerp(get_parent().global_position, get_global_mouse_position(), 100 * delta)
	else:
		selected = false
		if get_parent():
			if in_rest_zone and rest_point != null : 
				get_parent().global_position = lerp(get_parent().global_position, rest_point, 50 * delta)


#if item enters rest zone, set rest point to the zone's position
func item_entered_rest_zone(self_zone, _item) -> void:
		print("entered rest zone: ", self_zone)
		rest_point = self_zone.global_position
		print("restpoint pos: ", rest_point)
		in_rest_zone = true;

func item_left_rest_zone() -> void:
		print("left rest zone")
		rest_point = null
		in_rest_zone = false;

func _on_input_event(_viewport, _event, _shape_idx):
	selected = true;

func set_selected(b_value) -> void:
	selected = b_value

func set_is_processing_enabled(b_value) -> void:
	is_processing_enabled = b_value
