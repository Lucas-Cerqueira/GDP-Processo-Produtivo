extends Area2D

func _ready():
	pass

func Explode():
	var baseDamage = get_node("/root/GlobalVariables").lustDecoyExplosionDamage
	var array = get_overlapping_bodies()
	if (array.size() != 0):
		for enemy in array:
			enemy.TakeHit (baseDamage)
	
	queue_free()