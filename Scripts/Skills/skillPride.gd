extends Node

const DAMAGE_MULTIPLIER = 1.5

onready var GlobalVariables = get_node("/root/GlobalVariables")

var baseBlastDamage
var baseMEnemyDamage
var baseBEnemyDamage

func _ready():
	baseBlastDamage = GlobalVariables.playerBlastDamage
	baseMEnemyDamage = GlobalVariables.mEnemyAttackDamage
	baseBEnemyDamage = GlobalVariables.bEnemyAttackDamage
	if (GlobalVariables.skillAvailable[5]):
		GlobalVariables.playerBlastDamage = baseBlastDamage * DAMAGE_MULTIPLIER
		GlobalVariables.mEnemyAttackDamage = baseMEnemyDamage * DAMAGE_MULTIPLIER
		GlobalVariables.bEnemyAttackDamage = baseBEnemyDamage * DAMAGE_MULTIPLIER


func _on_Pride_exit_tree():
	GlobalVariables.playerBlastDamage = baseBlastDamage
	GlobalVariables.mEnemyAttackDamage = baseMEnemyDamage
	GlobalVariables.bEnemyAttackDamage = baseBEnemyDamage
