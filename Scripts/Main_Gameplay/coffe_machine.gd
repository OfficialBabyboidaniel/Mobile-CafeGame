extends Area2D

var has_mug
var rest_zone

# Called when the node enters the scene tree for the first time.
func _ready():
	has_mug = false
	rest_zone = $rest_zone
	rest_zone.rested.connect(addCoffeMug)
	rest_zone.un_rested.connect(removeCoffeMug)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func addCoffeMug():
	if not has_mug:
		has_mug = true
	# what if it has a mug

func removeCoffeMug():
	if has_mug:
		has_mug = false
