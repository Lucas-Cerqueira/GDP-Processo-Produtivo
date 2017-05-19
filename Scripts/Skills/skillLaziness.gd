extends Node

const SLOWDOWN_RATE = 2.0

onready var GlobalVariables = get_node("/root/GlobalVariables")
var baseSpeed

func _ready():
	baseSpeed = GlobalVariables.enemySpeed

func Activate(index):
	if (GlobalVariables.skillAvailable[index] &&
	GlobalVariables.skillCharges[index] > 0 && 
	not GlobalVariables.laziness_active):
		GlobalVariables.skillCharges[index] -= 1
		print ("Ativou LAZINESS")
		GlobalVariables.enemySpeed = baseSpeed / SLOWDOWN_RATE
		GlobalVariables.laziness_active = true
		get_child(0).start()

func _on_skillDuration_timeout():
	get_child(0).stop()
	GlobalVariables.enemySpeed = baseSpeed
	GlobalVariables.laziness_active = false


func _on_Laziness_exit_tree():
	get_child(0).stop()
	GlobalVariables.enemySpeed = baseSpeed
	GlobalVariables.laziness_active = false
