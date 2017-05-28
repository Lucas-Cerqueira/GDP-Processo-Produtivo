extends Area2D

var animationPlayer
var enable

func _ready():
	enable = true
	animationPlayer = get_node("AnimationPlayer")

func Explode():
	if (not enable):
		return
	var baseDamage = get_node("/root/GlobalVariables").lustDecoyExplosionDamage
	var array = get_overlapping_bodies()
	set_enable_monitoring(false)
	animationPlayer.play("explosion")
	if (array.size() != 0):
		for enemy in array:
			if (enemy.has_method("TakeHit")):
				enemy.TakeHit (baseDamage)

func _on_LustDecoy_exit_tree():
	enable = false
