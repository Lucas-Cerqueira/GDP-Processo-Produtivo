extends Node

var current_scene = null
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	set_process_input(true)

func _input(event):
	if (event.type == InputEvent.KEY):
		if (event.scancode == KEY_U):
			get_node("/root/GlobalVariables").skillAvailable[1] = true
			goto_scene("res://Scenes/Stages/stage1.tscn")

func goto_scene(path):
    call_deferred("_deferred_goto_scene",path)

func _deferred_goto_scene(path):
    current_scene.free()
    var s = ResourceLoader.load(path)
    current_scene = s.instance()

    get_tree().get_root().add_child(current_scene)

    get_tree().set_current_scene( current_scene )
