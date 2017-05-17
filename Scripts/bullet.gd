extends Node2D

export var bullet_speed = 300
export var bullet_damage = 25

var direction = 1
var hit = false

func _ready():
	set_process(true)

func _process(delta):
	translate (Vector2(bullet_speed*delta*direction, 0))

func  SetDirection (d):
	if (d == 1 or d == -1):
		direction = d

func _on_Area2D_body_enter( body ):
	#Qual a necessidade dessa variavel?
	if (hit == true):
		return
	hit = true
	
	#Coloquei essa linha aqui, que fez parar de dar um erro no debugger (o do condition !node...)
	#Nao sei exatamente o pq isso acontece lol
	get_node("Area2D").queue_free()
	
	body.TakeHit(bullet_damage)
	set_process(false)
	self.queue_free()



#Po, nunca usei esse VisibilityNotifier2D xD Sempre optei para que só o lifetime bastasse
func _on_VisibilityNotifier2D_exit_viewport( viewport ):
	#print ("Bullet destroyed")
	set_process(false)
	self.queue_free()


func _on_bulletLifeTime_timeout():
	pass
	#set_process(false)
	#self.queue_free()
