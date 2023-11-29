extends Area2D

var selected = false
var rest_point
var rest_nodes = []

# Called when the node enters the scene tree for the first time.


func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
	rest_point = rest_nodes[0].global_position
	rest_nodes[0].select()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 100 * delta)
	else: 
		global_position = lerp(global_position, rest_point, 50 * delta)


func _on_input_event(viewport, event, shape_idx):
	if(event.is_action_pressed("Action") ):
		selected = true
	if(event.is_action_released("Action") ):
		selected = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			var shortest_dist = 75
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist:
					child.select()
					rest_point = child.global_position
					shortest_dist = distance
# will this work for phones or not ? 
