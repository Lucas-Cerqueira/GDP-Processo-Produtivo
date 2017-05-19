extends Node

var playerMaxHealth = 100
var playerSpeed = 200
var playerMeleeDamage = 25
var playerBlastDamage = 50
var playerBlastSpeed = 600

var enemyMaxHealth = 100
var enemySpeed = 100
var enemyAttackDamage = 25

var gravity = 600

var skillAvailable = [false, false, false, false]
var skillCharges = [5, 5, 5, 5]

var laziness_active = false
var wrath_active = false

func _ready():
	set_process(true)