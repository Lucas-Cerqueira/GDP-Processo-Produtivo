extends Node

var current_scene = null
var current_stage = 0

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	set_process_input(true)

func _input(event):
	if (event.type == InputEvent.KEY && event.is_pressed() && !event.is_echo()):
		if (event.scancode == KEY_U):
			goto_next_stage()
			
func goto_next_stage():
	current_stage += 1
	current_stage = clamp (current_stage, 0, 7)
	if (current_stage > 0 && current_stage < 5):
		get_node("/root/GlobalVariables").skillAvailable[current_stage-1] = true
	goto_scene("res://Scenes/Stages/stage"+str(current_stage)+".tscn")

func goto_scene(path):
    call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
    current_scene.free()
    var s = ResourceLoader.load(path)
    current_scene = s.instance()

    get_tree().get_root().add_child(current_scene)

    get_tree().set_current_scene( current_scene )
