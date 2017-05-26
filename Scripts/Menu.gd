extends Node2D

var index = 0
var enableSelection = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	set_fixed_process(true)
	# Change the window name
	OS.set_window_title("The Last Angel")
	#Hide mouse when over on window
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass
	
func _input(event):
	if (not enableSelection):
		return
	
	if event.is_action("ui_up") && event.is_pressed() && !event.is_echo():
		if(index != 0):
			index -= 1
			var x = get_node("CanvasLayer/Selection").get_pos().x
			var y = get_node("CanvasLayer/Selection").get_pos().y - 75
			get_node("CanvasLayer/Selection").set_pos(Vector2(x,y))
	if event.is_action("ui_down") && event.is_pressed() && !event.is_echo():
		if(index != 3):
			index += 1
			var x = get_node("CanvasLayer/Selection").get_pos().x
			var y = get_node("CanvasLayer/Selection").get_pos().y + 75
			get_node("CanvasLayer/Selection").set_pos(Vector2(x,y))
	if event.is_action("ui_accept") && event.is_pressed() && !event.is_echo():
		if (index == 0):
			#Lucas: Mudei para usar esse script em todas as mudanças de cena porque ele toma uns cuidados extras
			get_node("/root/changeScene").goto_next_stage()
			#get_tree().change_scene("res://Scenes/Stages/tutorial.tscn")
			print("New Game")
		if (index == 1):
			enableSelection = false
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_node("CanvasLayer/Options_panel").show()
		if (index == 2):
			print("Credits")	
		if(index == 3):
			OS.get_main_loop().quit()

func _on_Button_button_down():
	enableSelection = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	get_node("CanvasLayer/Options_panel").hide()