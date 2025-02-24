extends CharacterBody2D

#dialouges to choose from, will have to be remade later. should their be dialoges specific per char or different random dialogues for every char
const lines: Array[String] = [
	"hey i want a coffe",
	"A cafe latte please",
	"Extra sugar",
]

var texture
var dialogue_database
const thank_you_line: Array[String] = ["Thank you for the coffe"]

@onready var text_box_location = $TextBoxLocation
signal customer_recieved_order  #is this used anywhere?


#choose between which dialog should be said depending of coffe_order state
func _ready():
	dialogue_database = $Dialogue_Database

	#say thank you line
	if GlobalSingleton.has_made_coffe:
		DialogManager.start_dialog(
			text_box_location.global_position,
			dialogue_database.dialogues["TESTAI"]["thank_you_line"]
		)
	#say order line	
	else:
		DialogManager.start_dialog(
			text_box_location.global_position, dialogue_database.dialogues["TESTAI"]["lines"]
		)
	DialogManager.order_completed.connect(_killCustomer)

#delete customer after thank you message is read
func _killCustomer():
	queue_free()
