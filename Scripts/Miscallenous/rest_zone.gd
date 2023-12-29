extends Area2D


#behövs alla dessa signaler?
var current_item
signal rested(current_item)
signal un_rested()
signal object_entered_rest_zone(self_zone, item)
signal object_left_rest_zone()

@export var correct_bool = false

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	#modulate = Color.BLUE
	rested.emit(current_item)
#	modulate.a = 0.05
func deselect():
	#modulate = Color.WHITE
	un_rested.emit()
#	modulate.a = 0.05



func _on_area_entered(area):
	if area.is_in_group("MovableObjects") : 
		current_item = area
		object_entered_rest_zone.emit(self, area)

func _on_area_exited(_area):
	object_left_rest_zone.emit()
