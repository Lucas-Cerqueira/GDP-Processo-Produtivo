extends Node

onready var GlobalVariables = get_node("/root/GlobalVariables")

var previousPressed = false


func _ready():
	set_process(true)


func _process(delta):
	var pressed = Input.is_action_pressed("skill_0") || Input.is_action_pressed("skill_1") || Input.is_action_pressed("skill_2") || Input.is_action_pressed("skill_3")
	if (Input.is_action_pressed("skill_0") && not previousPressed):
		get_child(0).Activate(0)
		
	elif (Input.is_action_pressed("skill_1") && not previousPressed):
		get_child(1).Activate(1)
		
	elif (Input.is_action_pressed("skill_2") && not previousPressed):
		get_child(2).Activate(2)
		
	elif (Input.is_action_pressed("skill_3") && not previousPressed):
		get_child(3).Activate(3)
		
	previousPressed = pressed
