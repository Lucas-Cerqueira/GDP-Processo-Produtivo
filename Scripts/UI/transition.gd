extends CanvasLayer

var scene_path = ""
var current_scene = null
var current_stage = -1

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	set_process_input(true)

func _input(event):
	if (event.type == InputEvent.KEY && event.is_pressed() && !event.is_echo()):
		if (event.scancode == KEY_U):
			goto_next_dialogue()

func goto_next_dialogue():
	current_stage += 1
	goto_scene("res://Scenes/Dialogues/dialogue"+str(current_stage)+".tscn")
	
func goto_next_stage():
	GlobalVariables.laziness_active = false
	GlobalVariables.wrath_active = false
	#current_stage += 1
	if (current_stage > 7):
		goto_scene("res://Scenes/Screens/credits.tscn")
	else:
		current_stage = clamp (current_stage, 0, 7)
		if (current_stage > 0 && current_stage < 8):
			GlobalVariables.skillAvailable[current_stage-1] = true
		
	
		GlobalVariables.previous_skillAvailable = GlobalVariables.skillAvailable + []
		GlobalVariables.previous_skillCharges = GlobalVariables.skillCharges + []	
		goto_scene("res://Scenes/Stages/stage"+str(current_stage)+".tscn")

func restart_stage():
	GlobalVariables.skillAvailable = GlobalVariables.previous_skillAvailable + []
	GlobalVariables.skillCharges = GlobalVariables.previous_skillCharges + []
	GlobalVariables.laziness_active = false
	GlobalVariables.wrath_active = false
	var root = get_tree().get_root()
	goto_scene("res://Scenes/Stages/stage"+str(current_stage)+".tscn")

func retry_game():
	current_stage = 1
	GlobalVariables.skillAvailable = [true, false, false, false, false, false, false]
	GlobalVariables.skillCharges = [5, 5, 5, 5]
	GlobalVariables.laziness_active = false
	GlobalVariables.wrath_active = false
	goto_scene("res://Scenes/Stages/stage1.tscn")

func goto_scene (path):
	scene_path = path
	get_node("AnimationPlayer").play("fadein_out")

func change_scene():
	if (not scene_path == ""):
		call_deferred("_deferred_goto_scene", scene_path)

#func goto_scene(path):
#    call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()

	get_tree().get_root().add_child(current_scene)

	get_tree().set_current_scene( current_scene )