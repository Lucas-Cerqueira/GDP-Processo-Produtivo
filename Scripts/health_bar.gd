extends Node2D
var health_bar 

func _ready():
	health_bar = get_node ("health_bar")

func UpdateHealthBar (current, maxHealth):
	current = clamp (current, 0, maxHealth)
	var ratio = current / float(maxHealth)
	health_bar.set_scale(Vector2 (ratio, 1))

#yOW! experimenta usar set_margin( MARGIN_RIGHT , valor ) em vez de set_scale.
#Na pratica é melhor pois vc nao altera o scale dos filhos (se tivesse) e também
#vc poderia usar uma imagem e ir cortando em vez de ir "apertando" ela.
#Com nodes do tipo control não é muito pratico usar scale(pq interface não usa muito escalonamento)