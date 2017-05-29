extends Node2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Retry_button_down():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_node("/root/changeScene").retry_game()


func _on_Exit_button_down():
	OS.get_main_loop().quit()
