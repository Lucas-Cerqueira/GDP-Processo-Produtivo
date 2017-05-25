extends Area2D

var animationPlayer

func _ready():
	animationPlayer = get_node("AnimationPlayer")

func Explode():
	var baseDamage = get_node("/root/GlobalVariables").lustDecoyExplosionDamage
	var array = get_overlapping_bodies()
	set_enable_monitoring(false)
	animationPlayer.play("explosion")
	if (array.size() != 0):
		for enemy in array:
			if (enemy.has_method("TakeHit")):
				enemy.TakeHit (baseDamage)