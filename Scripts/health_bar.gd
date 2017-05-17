extends Node2D
var health_bar 

func _ready():
	health_bar = get_node ("health_bar")

func UpdateHealthBar (current, maxHealth):
	current = clamp (current, 0, maxHealth)
	var ratio = current / float(maxHealth)
	health_bar.set_scale(Vector2 (ratio, 1))
