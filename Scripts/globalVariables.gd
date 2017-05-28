extends Node

var playerMaxHealth = 100
var playerSpeed = 200
var playerMeleeDamage = 25
var playerBlastDamage = 25
var playerBlastSpeed = 400
var playerBlastRateOfFire = 4  # playerBlastRateOfFire = X -> X shots per second

var enemyTarget
var mEnemyMaxHealth = 100
var mEnemySpeed = 100
var mEnemyAttackDamage = 25
var mEnemyAttackRange = 30

var bEnemyMaxHealth = 200
var bEnemySpeed = 50
var bEnemyAttackDamage = 50
var bEnemyAttackRange = 80

var lustDecoyExplosionDamage = 100

var gravity = 600

var skillAvailable = [false, false, false, false, false, false, false]
var skillCharges = [5, 5, 5, 5]

var previous_skillAvailable = [false, false, false, false]
var previous_skillCharges = [5, 5, 5, 5]

var laziness_active = false
var wrath_active = false

var avarice_chance = 10  # in percentage
var avarice_health_penalty = 5   # in points of health

var envy_heal_amount = 2

func _ready():
	set_process(true)