extends Node

const DAMAGE_MULTIPLIER = 2

onready var GlobalVariables = get_node("/root/GlobalVariables")

var baseBlastDamage
var baseMeleeDamage

var animationPlayer

func _ready():
	animationPlayer = get_node("../../AnimationPlayer")
	baseBlastDamage = GlobalVariables.playerBlastDamage
	baseMeleeDamage = GlobalVariables.playerMeleeDamage
	
func Activate(index):
	if (GlobalVariables.skillAvailable[index] && 
	GlobalVariables.skillCharges[index] > 0 &&
	not GlobalVariables.wrath_active):
		GlobalVariables.skillCharges[index] -= 1
		GlobalVariables.wrath_active = true
		get_child(0).start()
		
		print ("Ativou WRATH")
		GlobalVariables.playerBlastDamage = baseBlastDamage * DAMAGE_MULTIPLIER
		GlobalVariables.playerMeleeDamage = baseMeleeDamage * DAMAGE_MULTIPLIER
		animationPlayer.play("changeToRed")
	
func _on_skillDuration_timeout():
	get_child(0).stop()
	GlobalVariables.wrath_active = false
	GlobalVariables.playerBlastDamage = baseBlastDamage
	GlobalVariables.playerMeleeDamage = baseMeleeDamage
	animationPlayer.play("changeToWhite")


func _on_Wrath_exit_tree():
	get_child(0).stop()
	GlobalVariables.wrath_active = false
	GlobalVariables.playerBlastDamage = baseBlastDamage
	GlobalVariables.playerMeleeDamage = baseMeleeDamage
	animationPlayer.play("changeToWhite")