extends Node

export var spawnRange = 300

var decoyActive = false
var currentDecoy = null

onready var decoy_res = preload ("res://Scenes/lustDecoy.tscn")
onready var GlobalVariables = get_node("/root/GlobalVariables")

func Activate(index):
	if (GlobalVariables.skillAvailable[index] && GlobalVariables.skillCharges[index] > 0
	    && not decoyActive):
		GlobalVariables.skillCharges[index] -= 1
		get_child(0).start()
		print ("Ativou LUST")
		SpawnDecoy()
		GlobalVariables.enemyTarget = currentDecoy

func SpawnDecoy():
	decoyActive = true
	currentDecoy = decoy_res.instance()
	var player_pos = get_parent().get_parent().get_global_pos()
	randomize()
	var direction = randi()%2
	if (direction == 0): # Left
		direction = -1
	var distance = rand_range (0, spawnRange)
	currentDecoy.set_global_pos (player_pos + direction*Vector2(distance,0))
	get_tree().get_root().add_child(currentDecoy)
	

func _on_skillDuration_timeout():
	decoyActive = false
	get_child(0).stop()
	currentDecoy.Explode()
	currentDecoy = null
	GlobalVariables.enemyTarget = get_node("/root/main/Player2D")


func _on_Lust_exit_tree():
	decoyActive = false
	get_child(0).stop()
	if (currentDecoy):
		currentDecoy.Explode()
		currentDecoy = null
	GlobalVariables.enemyTarget = get_node("/root/main/Player2D")