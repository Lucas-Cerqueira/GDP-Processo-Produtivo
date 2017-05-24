extends Node

var playerMaxHealth = 100
var playerSpeed = 200
var playerMeleeDamage = 25
var playerBlastDamage = 50
var playerBlastSpeed = 600

var enemyTarget
var mEnemyMaxHealth = 100
var mEnemySpeed = 100
var mEnemyAttackDamage = 25
var mEnemyAttackRange = 30

var bEnemyMaxHealth = 200
var bEnemySpeed = 50
var bEnemyAttackDamage = 50
var bEnemyAttackRange = 60

var lustDecoyExplosionDamage = 100

var gravity = 600

var skillAvailable = [false, false, false, false]
var skillCharges = [5, 5, 5, 5]

var laziness_active = false
var wrath_active = false

func _ready():
	set_process(true)