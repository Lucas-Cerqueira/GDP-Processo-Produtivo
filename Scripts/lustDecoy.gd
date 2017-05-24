extends Area2D

func _ready():
	pass

func Explode():
	var baseDamage = get_node("/root/GlobalVariables").lustDecoyExplosionDamage
	var array = get_overlapping_bodies()
	set_enable_monitoring(false)
	if (array.size() != 0):
		for enemy in array:
			if (enemy.has_method("TakeHit")):
				enemy.TakeHit (baseDamage)
	
	queue_free()