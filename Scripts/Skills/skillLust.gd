extends Node

export var spawnRange = 300

var decoyActive = false
var currentDecoy = null

onready var decoy_res = preload ("res://Scenes/lustDecoy.tscn")


func Activate(index):
	if (GlobalVariables.skillAvailable[index] && GlobalVariables.skillCharges[index] > 0
	    && not decoyActive):
		var x = randi()%100
		if (GlobalVariables.skillAvailable[4] && x < GlobalVariables.avarice_chance):
			get_parent().get_parent().TakeHit(GlobalVariables.avarice_health_penalty)
		else:
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
	var direction = get_parent().get_parent().get_node("Sprite").get_scale().x
	var distance = rand_range (100, spawnRange)
	currentDecoy.set_global_pos (player_pos + direction*Vector2(distance,0))
	get_node('/root/main').add_child(currentDecoy)


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
