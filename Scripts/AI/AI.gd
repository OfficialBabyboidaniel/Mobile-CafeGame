extends CharacterBody2D

#dialouges to choose from, will have to be remade later. should their be dialoges specific per char or different random dialogues for every char
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
	

func _killCustomer():
	
	queue_free()
	


