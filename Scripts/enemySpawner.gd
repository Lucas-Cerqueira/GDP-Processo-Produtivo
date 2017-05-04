extends Node2D

export var numberOfEnemies = 5

var timer
var spawnedEnemies = 0

func _ready():
	timer = get_node("SpawnDelay")
	timer.start()

func _on_SpawnDelay_timeout():
	if (spawnedEnemies < numberOfEnemies):
		var enemy = preload("res://Scenes/enemy.tscn").instance()
		add_child(enemy)
		spawnedEnemies += 1
		timer.start()
	else:
		timer.stop()