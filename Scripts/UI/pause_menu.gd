extends Panel

var paused = false


func _ready():
	set_process_input(true)


func _input(event):
	if (event.type == InputEvent.KEY && event.is_pressed() && !event.is_echo()):
		if (event.scancode == KEY_ESCAPE || event.scancode == KEY_P):
			if (not paused):
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
				paused = true
				get_tree().set_pause(true)
				self.show()
			else:
				Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
				paused = false
				get_tree().set_pause(false)
				self.hide()


func _on_Resume_button_button_down():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	paused = false
	get_tree().set_pause(false)
	self.hide()


func _on_RestartStage_button_button_down():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	paused = false
	get_tree().set_pause(false)
	self.hide()
	get_node("/root/changeScene").restart_stage()


func _on_Exit_button_button_down():
	OS.get_main_loop().quit()


func _on_SoundCheckButton_toggled( pressed ):
	AudioServer.set_stream_global_volume_scale(float(pressed))
	AudioServer.set_fx_global_volume_scale(float(pressed))
