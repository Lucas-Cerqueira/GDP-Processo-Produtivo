extends Node

var waveNumber = 1
var waveInfo
var spawners
var enemiesLeft

func _ready():
	waveInfo = get_node("/root/main/UI/WaveInfo")
	spawners = get_children()
	enemiesLeft = 0
	for node in spawners:
		enemiesLeft += node.numberOfEnemies[waveNumber-1]
	set_process(true)

func _process(delta):
	waveInfo.text = "Wave: "+ str(waveNumber) + "\nEnemies left: " + str(enemiesLeft)

func GetWaveNumber():
	return waveNumber

func StartWave (number):
	enemiesLeft = 0
	for node in spawners:
		node.StartWave(number)
		enemiesLeft += node.numberOfEnemies[waveNumber-1]

func ChangeScene ():
	print ("Change scene")

func EnemyKilled():
	enemiesLeft -= 1
	if (enemiesLeft == 0):
		if (waveNumber < 3):
			waveNumber += 1
			StartWave (waveNumber)
		else:
			ChangeScene()