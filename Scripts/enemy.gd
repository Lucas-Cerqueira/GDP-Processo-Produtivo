extends Node2D

export var maxHealth = 100
var health

func _ready():
	health = maxHealth

func Take_hit (damage):
	health -= damage
	if health <= 0:
		set_process(false)
		self.queue_free()