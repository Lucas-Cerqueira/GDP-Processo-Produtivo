extends Node2D

var direction = 1
var hit = false

func _ready():
	set_process(true)

func _process(delta):
	translate (Vector2(GlobalVariables.playerBlastSpeed*delta*direction, 0))

func  SetDirection (d):
	if (d == 1 or d == -1):
		direction = d

func _on_Area2D_body_enter( body ):
	#Qual a necessidade dessa variavel?
	# Lucas: Tava pegando o hit mais de uma vez
	if (hit == true):
		return
	hit = true
	
	#Coloquei essa linha aqui, que fez parar de dar um erro no debugger (o do condition !node...)
	#Nao sei exatamente o pq isso acontece lol
	get_node("Area2D").queue_free()
	
	body.TakeHit(GlobalVariables.playerBlastDamage)
	set_process(false)
	self.queue_free()


func _on_bulletLifeTime_timeout():
	set_process(false)
	self.queue_free()