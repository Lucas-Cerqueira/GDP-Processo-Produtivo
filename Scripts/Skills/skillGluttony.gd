extends Node

onready var GlobalVariables = get_node("/root/GlobalVariables")

func Activate(index):
	if (GlobalVariables.skillAvailable[index] && GlobalVariables.skillCharges[index] > 0):
		GlobalVariables.skillCharges[index] -= 1
		get_child(0).start()
		print ("Ativou GLUTTONY")

func _on_skillDuration_timeout():
	get_child(0).stop()
