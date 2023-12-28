extends Area2D


var selected = false
var in_rest_zone = false

#current rest point and available rest nodes
var rest_point
var rest_nodes = []


#get rest_nodes and set rest point to first node in tree
func _ready(): 
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()
	if rest_nodes.size() > 0:
		for child in rest_nodes:
			if is_instance_valid(child) and child is Area2D:
				rest_point = child.global_position
				child.select()
				#child.connect("object_entered_rest_zone", self, "item_entered_rest_zone")
				child.object_entered_rest_zone.connect(item_entered_rest_zone)
				child.object_left_rest_zone.connect(item_left_rest_zone)

#check if mug is being held and move it wtih lerp. Move it back to its starting position if mug has been released
func _process(delta):
	if Input.is_action_pressed("Action") :
		global_position = lerp(global_position, get_global_mouse_position(), 100 * delta)
		selected = true;
	else:
		if in_rest_zone and rest_point != null: 
			global_position = lerp(global_position, rest_point, 50 * delta)
			selected = false

func item_entered_rest_zone(zone):
		print("entered rest zone: ", zone)
		zone.select()
		rest_point = zone.global_position
		print("restpoint pos: ", rest_point)
		in_rest_zone = true;

func item_left_rest_zone():
		print("left rest zone")
		rest_point = null
		in_rest_zone = false;
