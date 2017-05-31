extends Node2D

var canSkip = false


func _ready():
	set_process_input(true)


func _input(event):
	if (event.type == InputEvent.KEY && canSkip):
		Transition.goto_scene("res://Scenes/Menu.tscn")
		canSkip = false


func _on_Timer_timeout():
	canSkip = true
