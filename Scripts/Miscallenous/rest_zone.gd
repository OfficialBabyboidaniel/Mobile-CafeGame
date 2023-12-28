extends Area2D

signal rested()
signal un_rested()
signal object_entered_rest_zone(zone)
signal object_left_rest_zone()

@export var correct_bool = false

func _on_draw():
	pass
	#draw_circle(Vector2.ZERO, 75, Color.YELLOW)
#	modulate.a = 0.05

func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	#modulate = Color.BLUE
	rested.emit()
#	modulate.a = 0.05
func deselect():
	#modulate = Color.WHITE
	un_rested.emit()
#	modulate.a = 0.05



func _on_area_entered(area):
	object_entered_rest_zone.emit(self)

func _on_area_exited(_area):
	object_left_rest_zone.emit()
