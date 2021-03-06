extends Node2D

export var enemy_res = preload("res://Scenes/Enemies/mEnemy.tscn")
export(IntArray) var numberOfEnemies = [5, 10, 15]
export var enabled = true

var timer
var spawnedEnemies = 0
var waveHandler

func _ready():
	timer = get_node("SpawnDelay")
	waveHandler = get_parent()
	StartWave(1)

func StartWave (number):
	if (enabled):
		spawnedEnemies = 0
		SpawnEnemy()
		timer.start()

func _on_SpawnDelay_timeout():
	SpawnEnemy()


func SpawnEnemy():
	if (spawnedEnemies < numberOfEnemies[waveHandler.GetWaveNumber()-1] && enabled):
		var enemy = enemy_res.instance()
		if ("mEnemy" in enemy.get_name()):
			enemy.enemyType = "medium"
		else:
			enemy.enemyType = "big"
		add_child(enemy)
		spawnedEnemies += 1
		timer.start()
	else:
		timer.stop()