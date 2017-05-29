extends Node

onready var GlobalVariables = get_node("/root/GlobalVariables")


func _ready():
	var arrayAvailable = GlobalVariables.skillAvailable
	for i in range(arrayAvailable.size()):
		if (arrayAvailable[i]):
			get_child(i).show()
		else:
			get_child(i).hide()
	set_process(true)


func _process(delta):
	var arrayCharges = GlobalVariables.skillCharges
	for i in range(arrayCharges.size()):
		get_child(i).get_node("Charges").text = "Charges: " + str(arrayCharges[i])
