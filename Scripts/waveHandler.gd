extends Node

const WAVE_DELAY = 2

var waveNumber = 1
var waveInfo
var spawners
var enemiesLeft

var spawnEnable = true
var counter = 0

var player

onready var GlobalVariables = get_node("/root/GlobalVariables")
onready var changeScene = get_node("/root/changeScene")

func _ready():
	player = get_node("/root/main/Player2D")
	waveInfo = get_node("/root/main/UI/WaveInfo")
	spawners = get_children()
	enemiesLeft = 0
	for node in spawners:
		enemiesLeft += node.numberOfEnemies[waveNumber-1]
	set_process(true)

func _process(delta):
	waveInfo.text = "Wave: "+ str(waveNumber) + "\nEnemies left: " + str(enemiesLeft)
	if (not spawnEnable):
		counter += delta
		if (counter >= 2):
			StartWave (waveNumber)
			spawnEnable = true
			counter = 0

func GetWaveNumber():
	return waveNumber

func StartWave (number):
	enemiesLeft = 0
	for node in spawners:
		node.StartWave(number)
		enemiesLeft += node.numberOfEnemies[waveNumber-1]

func ChangeScene ():
	changeScene.goto_next_stage()

func EnemyKilled():
	# If ENVY is unlocked, player steals some life from the dead enemy
	var x = randi()%100
	if (GlobalVariables.skillAvailable[6]):
		player.HealPlayer (GlobalVariables.envy_heal_amount)
	
	enemiesLeft -= 1
	if (enemiesLeft == 0):
		if (waveNumber < 3):
			waveNumber += 1
			spawnEnable = false
			waveInfo.get_node("AnimationPlayer").play("highlight")
			for node in spawners:
				enemiesLeft += node.numberOfEnemies[waveNumber-1]
		else:
			ChangeScene()