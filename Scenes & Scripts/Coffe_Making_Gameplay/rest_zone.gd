extends Area2D


#are all these signals needed?
var current_item
signal object_entered_rest_zone(self_zone, item)
signal object_left_rest_zone()

@export var correct_bool = false

#rest node entered + exited
#emit signal and set current item, if Area2D node entered is of group movable objects
func _on_area_entered(area):
	print("Area entered: ", area.get_parent())
	if !area.get_parent():
		return;
	if area.get_parent().is_in_group("MovableObjects") : 
		current_item = area.get_parent()
		object_entered_rest_zone.emit(self, current_item)

#emit signal and set current item to null, when exited Rest node
func _on_area_exited(_area):
	object_left_rest_zone.emit()
	current_item = null
