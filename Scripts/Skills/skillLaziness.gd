extends Node

const SLOWDOWN_RATE = 2.0

onready var GlobalVariables = get_node("/root/GlobalVariables")
var mEnemySpeed
var bEnemySpeed


func _ready():
	mEnemySpeed = GlobalVariables.mEnemySpeed
	bEnemySpeed = GlobalVariables.bEnemySpeed


func Activate(index):
	if (GlobalVariables.skillAvailable[index] &&
	GlobalVariables.skillCharges[index] > 0 && 
	not GlobalVariables.laziness_active):
		var x = randi()%100
		if (GlobalVariables.skillAvailable[4] && x < GlobalVariables.avarice_chance):
			get_parent().get_parent().TakeHit(GlobalVariables.avarice_health_penalty)
		else:
			GlobalVariables.skillCharges[index] -= 1
		print ("Ativou LAZINESS")
		GlobalVariables.mEnemySpeed = mEnemySpeed / SLOWDOWN_RATE
		GlobalVariables.bEnemySpeed = bEnemySpeed / SLOWDOWN_RATE
		GlobalVariables.laziness_active = true
		get_child(0).start()


func _on_skillDuration_timeout():
	get_child(0).stop()
	GlobalVariables.mEnemySpeed = mEnemySpeed
	GlobalVariables.bEnemySpeed = bEnemySpeed
	GlobalVariables.laziness_active = false


func _on_Laziness_exit_tree():
	get_child(0).stop()
	GlobalVariables.mEnemySpeed = mEnemySpeed
	GlobalVariables.bEnemySpeed = bEnemySpeed
	GlobalVariables.laziness_active = false
