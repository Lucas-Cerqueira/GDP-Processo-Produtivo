extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var index = 0

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
	if event.is_action("ui_up") && event.is_pressed() && !event.is_echo():
		if(index != 0):
			index -= 1
			var x = get_node("Sprite/Selection").get_pos().x
			var y = get_node("Sprite/Selection").get_pos().y - 75
			get_node("Sprite/Selection").set_pos(Vector2(x,y))
	if event.is_action("ui_down") && event.is_pressed() && !event.is_echo():
		if(index != 3):
			index += 1
			var x = get_node("Sprite/Selection").get_pos().x
			var y = get_node("Sprite/Selection").get_pos().y + 75
			get_node("Sprite/Selection").set_pos(Vector2(x,y))
	if event.is_action("ui_accept") && event.is_pressed() && !event.is_echo():
		if (index == 0):
			#Lucas: Mudei para usar esse script em todas as mudanças de cena porque ele toma uns cuidados extras
			get_node("/root/changeScene").goto_scene("res://Scenes/Stages/tutorial.tscn")
			#get_tree().change_scene("res://Scenes/Stages/tutorial.tscn")
			print("New Game")
		if (index == 1):
			print("Options")
		if (index == 2):
			print("Credits")	
		if(index == 3):
			OS.get_main_loop().quit()