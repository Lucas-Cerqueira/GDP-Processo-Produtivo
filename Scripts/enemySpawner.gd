extends Node2D

export var numberOfEnemies = 5

var timer
var spawnedEnemies = 0

func _ready():
	timer = get_node("SpawnDelay")
	SpawnEnemy()

func _on_SpawnDelay_timeout():
	SpawnEnemy()



#Não sei se por chamar o preload sempre que for instanciar um inimigo ele vai
# carregar o arquivo novamente, mesmo que seja preload e não load.
#Uma alternativa que eu gosto:

onready var enemy_res = preload("res://Scenes/enemy.tscn")

#Certamente aqui você só chamou preload uma vez.
#a palavra chave onready serve pra vc pode usar funções e setar o valor das variaveis por aqui mesmo :P

func SpawnEnemy():
	if (spawnedEnemies < numberOfEnemies):
		var enemy = preload("res://Scenes/enemy.tscn").instance()
		add_child(enemy)
		spawnedEnemies += 1
		timer.start()
	else:
		timer.stop()