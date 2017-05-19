extends Node

onready var GlobalVariables = get_node("/root/GlobalVariables")

var active = false

func _ready():
	set_process(true)

func _process(delta):
	if (GlobalVariables.wrath_active && not active):
		active = true
		get_node("SmokeRight").set_emitting(true)
		get_node("SmokeLeft").set_emitting(true)
			
	elif (GlobalVariables.wrath_active == false && active):
		active = false
		get_node("SmokeRight").set_emitting(false)
		get_node("SmokeLeft").set_emitting(false)