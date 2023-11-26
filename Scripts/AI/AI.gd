extends CharacterBody2D

const lines: Array[String] = [
	"hey i want a coffe",
	"A cafe latte please",
	"Extra sugar",
]

const thank_you_line: Array[String] = ["Thank you for the coffe"]
signal customer_recieved_order()

# Called when the node enters the scene tree for the first time.
func _ready():
	if(GlobalSingleton.has_made_coffe):
		DialogManager.start_dialog(global_position, thank_you_line)
	else:
		DialogManager.start_dialog(global_position, lines)
	DialogManager.order_completed.connect(_killCustomer)
	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move_local_y(5 * delta);
	pass
	
func _killCustomer():
	
	queue_free()
	


